namespace :db do
  DUMP_FMT = 't' # 'c', 'p', 't', 'd'

  desc 'Efetuar dump da base de dados'
  task sql_dump: :environment do
    dump_sfx = suffix_for_format(DUMP_FMT)
    backup_dir = backup_directory(true)
    cmd = nil
    with_config do |app, host, db, user|
        file_name = Time.now.strftime("%Y%m%d%H%M%S") + "_" + db + '.' + dump_sfx
        cmd = "pg_dump -F #{DUMP_FMT} -U #{user} -v --no-owner -h #{host} -d #{db} -f #{backup_dir}/#{file_name}"
    end
    puts cmd
    exec cmd
  end

  desc 'Efetuar dump de uma tabela/backup específico'
  task sql_dump_table: :environment do |_task, args|
    table_name = ENV['table']
    fail ArgumentError unless table_name
    dump_sfx = suffix_for_format(DUMP_FMT)
    backup_dir = backup_directory(true)
    cmd = nil
    with_config do |app, host, db, user|
        file_name = Time.now.strftime("%Y%m%d%H%M%S") + "_" + db + "_#{table_name.parameterize.underscore}" + '.' + dump_sfx
        cmd = "pg_dump --table #{table_name} --no-owner -F #{DUMP_FMT} -U #{user} -v -h #{host} -d #{db} -f #{backup_dir}/#{file_name}"
    end
    puts cmd
    exec cmd
  end

  desc 'Mostrar os backups existentes'
  task list_backups: :environment do
      backup_dir = backup_directory
      puts "#{backup_dir}"
      exec "/bin/ls -lt #{backup_dir}"
  end

  desc 'Mostrar o último backups efetuado'
  task last_backup: :environment do
      backup_dir = backup_directory
      puts "#{backup_dir}"
      exec "/bin/ls -1t #{backup_dir} | head -1"
  end

  # ls -1t | head -5

  # Comando: RAILS_ENV=staging bundle exec rake db:sql_restore[20171214084630_sgpe_production.tar]
  desc 'Restaurar a base de dados do backup usando PATTERN'
  task :sql_restore, [:pat] => :environment do |task,args|
      if args.pat.present?
          cmd = nil
          with_config do |app, host, db, user|
              backup_dir = backup_directory
              puts Dir.glob("#{backup_dir}/*#{args.pat}*")
              files = Dir.glob("#{backup_dir}/*#{args.pat}*")
              case files.size
              when 0
                puts "Nenhum backup encontrado para o padrão '#{args.pat}'"
              when 1
                file = files.first
                fmt = format_for_file file
                if fmt.nil?
                  puts "Sufixo do arquivo dump não reconhecido: #{file}"
                else
                  cmd = "pg_restore -F #{fmt} -U #{user} -d #{db} -v -c #{file}"
                  # cmd = "pg_restore -F #{fmt} -U #{user} -d #{db} -v -c -C #{file}"
                end
              else
                puts "Muitos arquivos não conferem com o padrão '#{args.pat}':"
                puts ' ' + files.join("\n ")
                puts "Tente um padrão mais específico"
              end
          end
          unless cmd.nil?
            # Rake::Task["db:drop"].invoke
            # Rake::Task["db:create"].invoke
            Rake::Task["db:migrate"].invoke
            puts cmd
            exec cmd
            # Rake::Task["db:migrate"].invoke
          end
      else
          puts 'Informe o padrão da tarefa'
      end
  end

  private

  def suffix_for_format suffix
      case suffix
      when 'c' then 'dump'
      when 'p' then 'sql'
      when 't' then 'tar'
      when 'd' then 'dir'
      else nil
      end
  end

  def format_for_file file
      case file
      when /\.dump$/ then 'c'
      when /\.sql$/  then 'p'
      when /\.dir$/  then 'd'
      when /\.tar$/  then 't'
      else nil
      end
  end

  def backup_directory(create=false)
      # backup_dir = "#{Rails.root}/db/backups"
      backup_dir = "#{ENV['HOME']}/Dropbox/db/backups"
      if create and not Dir.exists?(backup_dir)
        puts "Creating #{backup_dir} .."
        # Dir.mkdir(backup_dir)
        FileUtils.mkdir_p(backup_dir)
      end
      backup_dir
  end

  def with_config
      yield Rails.application.class.parent_name.underscore,
            ActiveRecord::Base.connection_config[:host],
            ActiveRecord::Base.connection_config[:database],
            ActiveRecord::Base.connection_config[:username]
  end
end
