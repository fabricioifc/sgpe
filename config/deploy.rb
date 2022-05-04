require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'  # for rbenv support. (https://rbenv.org)
# require 'mina/rvm'    # for rvm support. (https://rvm.io)
require 'mina/puma'
require 'mina/whenever'
require 'mina_sidekiq/tasks'

# Ruby Version
# set :ruby_version, '2.4.0'

# Repository project
# set :repository, 'git@bitbucket.org:fraiburgoifc/planodeensinoifc.git'
set :repository, 'git@github.com:fabricioifc/sgpe.git'

# Server Production
task :production => :remote_environment do
  set :rails_env, 'production'
  set :user, 'fabricio'
  set :domain, 'fabriciobizotto.ddns.net'
  set :port, '50235'
  set :deploy_to, '/home/fabricio/sgpe_production'
  set :branch, 'videira'
  # set :whenever_name, 'production'
end

# # Server Staging
# task :staging => :remote_environment do
#   set :rails_env, 'staging'
#   set :user, 'deploy'
#   set :domain, '200.135.61.15'
#   set :port, '50235'
#   set :deploy_to, '/home/deploy/sgpe_staging'
#   set :branch, 'staging'
# end

# Fix
set :term_mode, nil
set :forward_agent, true
# set :whenever_name, "#{domain}_#{fetch(:rails_env)}"

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_dirs, fetch(:shared_dirs, []).push('log', 'tmp/pids', 'tmp/sockets', 'public/uploads')
set :shared_files, fetch(:shared_files, []).push(
  'config/database.yml', 'config/secrets.yml', 'config/puma.rb',
  '.env', '.env.test', '.env.development', '.env.staging', '.env.production'
)

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :remote_environment do
  invoke :'rbenv:load'
  # Necessário para funcionar o comando rake via crontab e whenever
  # command %[echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile]
  # command %[echo 'eval "$(rbenv init -)"' >> ~/.bash_profile]
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :remote_environment do
  command %[mkdir -p "#{fetch(:shared_path)}/tmp/pids"]
  command %[mkdir -p "#{fetch(:shared_path)}/log"]
  command %[mkdir -p "#{fetch(:shared_path)}/tmp/sockets"]
  command %[touch "#{fetch(:shared_path)}/config/database.yml"]
  command %[touch "#{fetch(:shared_path)}/config/secrets.yml"]
  command %[touch "#{fetch(:shared_path)}/config/puma.rb"]
  command %[touch "#{fetch(:shared_path)}/.env.development"]
  command %[touch "#{fetch(:shared_path)}/.env.test"]
  command %[touch "#{fetch(:shared_path)}/.env.staging"]
  command %[touch "#{fetch(:shared_path)}/.env.production"]
end

desc "Deploys the current version to the server."
task :deploy => :remote_environment do
  deploy do
  	invoke :'git:clone'
    # invoke :'sidekiq:quiet'
  	invoke :'deploy:link_shared_paths'
  	invoke :'bundle:install'
  	invoke :'rails:db_migrate'
    command %{#{fetch(:rails)} db:seed}
  	invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      invoke :'puma:phased_restart'
      # invoke :'sidekiq:restart'
      invoke :'whenever:update'
    end
  end
end

namespace :maintenance do
  task :on => :remote_environment do
    command %[echo "-----> Iniciando modo manutenção --#{fetch(:rails_env)}--"]
    command %[cd #{fetch(:deploy_to)}/current]
    command %[RAILS_ENV=#{fetch(:rails_env)} bundle exec rake maintenance:start]
    # command %[RAILS_ENV=#{fetch(:rails_env)} bundle exec rake maintenance:enable]
  end

  task :off => :remote_environment do
    command %[echo "-----> Finalizando modo manutenção --#{fetch(:rails_env)}--"]
    command %[cd #{fetch(:deploy_to)}/current]
    command %[RAILS_ENV=#{fetch(:rails_env)} bundle exec rake maintenance:end]
    # command %[RAILS_ENV=#{fetch(:rails_env)} bundle exec rake maintenance:disable]
  end
end

# namespace :redis do
#
#   desc "Install the latest release of Redis"
#   task :install do
#     invoke :sudo
#     command %{echo "-----> Installing Redis..."}
#     command "sudo add-apt-repository -y ppa:chris-lea/redis-server --yes"
#     command "sudo apt-get -y update"
#     command "sudo apt-get -y install redis-server"
#   end
#
#   task(:setup) {  }
#
#   %w[start stop restart].each do |command|
#     desc "#{command} redis"
#     task command do
#       invoke :sudo
#       command %{echo "-----> Trying to #{command} Redis..."}
#       command "#{sudo} service redis #{command}"
#     end
#   end
#
# end



# desc "BACKUP"
task :backup => :remote_environment do
  command %[echo "-----> Iniciando o DUMP #{fetch(:domain)}!"]
  # command %{#{fetch(:rails)} db:sql_dump}
  command %[cd #{fetch(:deploy_to)}/current]
  # command %[echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p]
  command %[bundle exec rake db:sql_dump]
end
# desc "Rolls back the latest release"
# task :rollback => :remote_environment do
#   command %[echo "-----> Rolling back to previous release for #{fetch(:domain)}!"]
#
#   # Delete existing sym link and create a new symlink pointing to the previous release
#   command %[echo -n "-----> Creating new symlink from the previous release: "]
#   command %[ls "#{fetch(:deploy_to)}/releases" -Art | sort | tail -n 2 | head -n 1]
#   command %[ls -Art "#{fetch(:deploy_to)}/releases" | sort | tail -n 2 | head -n 1 | xargs -I active ln -nfs "#{fetch(:deploy_to)}/releases/active" "#{fetch(:deploy_to)}/current"]
#
#   # Remove latest release folder (active release)
#   command %[echo -n "-----> Deleting active release: "]
#   command %[ls "#{fetch(:deploy_to)}/releases" -Art | sort | tail -n 1]
#   command %[ls "#{fetch(:deploy_to)}/releases" -Art | sort | tail -n 1 | xargs -I active rm -rf "#{fetch(:deploy_to)}/releases/active"]
#
#   # command %[cd #{fetch(:deploy_to)}/current]
#   # command %[(bundle exec pumactl -p $(cat #{fetch(:deploy_to)}/shared/tmp/pids/puma.pid) stop && bundle exec pumactl start) || bundle exec pumactl start]
# end
