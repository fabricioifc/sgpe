require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'  # for rbenv support. (https://rbenv.org)
# require 'mina/rvm'    # for rvm support. (https://rvm.io)
require 'mina/puma'

# Ruby Version
# set :ruby_version, '2.4.0'

# Repository project
set :repository, 'git@bitbucket.org:fraiburgoifc/planodeensinoifc.git'

# Server Production
task :production do
  set :rails_env, 'production'
  set :user, 'deploy'
  set :domain, '200.135.61.15'
  set :port, '50235'
  set :deploy_to, '/home/deploy/sgpe_production'
  set :branch, 'master'
end

# Server Staging
task :staging do
  set :rails_env, 'staging'
  set :user, 'deploy'
  set :domain, '200.135.61.15'
  set :port, '50235'
  set :deploy_to, '/home/deploy/sgpe_staging'
  set :branch, 'staging'
end

# Fix
set :term_mode, nil
set :forward_agent, true

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_dirs, fetch(:shared_dirs, []).push('log', 'tmp/pids', 'tmp/sockets', 'public/uploads')
set :shared_files, fetch(:shared_files, []).push(
  'config/database.yml', 'config/secrets.yml', 'config/puma.rb',
  '.env.test', '.env.development', '.env.staging', '.env.production'
)

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  invoke :'rbenv:load'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
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
task :deploy => :environment do
  deploy do
  	invoke :'git:clone'
  	invoke :'deploy:link_shared_paths'
  	invoke :'bundle:install'
  	invoke :'rails:db_migrate'
    command %{#{fetch(:rails)} db:seed}
  	invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      invoke :'puma:phased_restart'
    end
  end
end

# desc "Rolls back the latest release"
# task :rollback => :environment do
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
