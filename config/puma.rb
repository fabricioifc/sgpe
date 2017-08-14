# Change to match your CPU core count
workers 2
# Min and Max threads per worker
threads 1, 6
# root directory
app_dir = File.expand_path("../..", __FILE__)
# shared directory
shared_dir = "#{app_dir}/tmp" if ["development", "test"].include? Rails.env
shared_dir = "#{app_dir}/shared" unless ["development", "test"].include? Rails.env
# port
port ENV.fetch("PORT") { 3000 } if ["development", "test"].include? Rails.env
# Ambiente
environment ENV.fetch("environment") { "production" }
# Set up socket location
bind "unix://#{shared_dir}/sockets/puma.sock"
# bind  "unix:///home/deploy/sgpe/shared/tmp/sockets/puma.sock"
# Set master PID and state locations
pidfile "#{shared_dir}/pids/puma.pid"
# pidfile "/home/deploy/sgpe/shared/tmp/pids/puma.pid"
state_path "#{shared_dir}/pids/puma.state"
# state_path "/home/deploy/sgpe/shared/tmp/sockets/puma.state"
activate_control_app "unix://#{shared_dir}/sockets/pumactl.sock"
# app directory
directory "#{app_dir}" if ["development", "test"].include? Rails.env
directory "#{app_dir}/current" unless ["development", "test"].include? Rails.env
# rodar em background
daemonize true unless ["development", "test"].include? Rails.env

# prune_bundler

# threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
# threads threads_count, threads_count
# port        ENV.fetch("PORT") { 3000 }
# environment ENV.fetch("RAILS_ENV") { "development" }
# plugin :tmp_restart
