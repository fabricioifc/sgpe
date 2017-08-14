require 'mina/multistage'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'  # for rbenv support. (https://rbenv.org)
# require 'mina/rvm'    # for rvm support. (https://rvm.io)
require 'mina/puma'

set :shared_dirs, fetch(:shared_dirs, []).push('log', 'pids', 'sockets', 'public/uploads')
set :shared_files, fetch(:shared_files, []).push(
  'config/database.yml', 'config/secrets.yml', 'config/puma.rb',
  '.env.test', '.env.development', '.env.staging', '.env.production'
)

desc "Deploys the current version to the server."
task deploy: :environment do
  comment "Deploying #{fetch(:application_name)} to #{fetch(:domain)}:#{fetch(:deploy_to)}"
  invoke :'git:clone'
  invoke :'deploy:link_shared_paths'
  # invoke :'rvm:load_env_vars'
  invoke :'bundle:install'
  invoke :'rails:db_migrate'
  command %{#{fetch(:rails)} db:seed}
  invoke :'rails:assets_precompile'
  invoke :'deploy:cleanup'

  on :launch do
    invoke :'puma:phased_restart'
    # invoke :'unicorn:restart'
  end
end

task :environment do
  invoke :'rbenv:load'
  # invoke :'rvm:use', 'ruby-2.4.0@default'
end

task setup: :environment do
  command %[mkdir -p "#{fetch(:shared_path)}/pids"]
  command %[mkdir -p "#{fetch(:shared_path)}/log"]
  command %[mkdir -p "#{fetch(:shared_path)}/sockets"]
  command %[touch "#{fetch(:shared_path)}/config/database.yml"]
  command %[touch "#{fetch(:shared_path)}/config/secrets.yml"]
  command %[touch "#{fetch(:shared_path)}/config/puma.rb"]
  command %[touch "#{fetch(:shared_path)}/.env.development"]
  command %[touch "#{fetch(:shared_path)}/.env.test"]
  command %[touch "#{fetch(:shared_path)}/.env.staging"]
  command %[touch "#{fetch(:shared_path)}/.env.production"]
  comment "Be sure to edit '#{fetch(:shared_path)}/config/database.yml', 'secrets.yml' and puma.rb."
end
