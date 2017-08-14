# Change to match your CPU core count
workers 2
# Min and Max threads per worker
threads 1, 6
# root directory
environment ENV.fetch("ENVIRONMENT") { 'development' }
port  ENV.fetch("PORT") { '3000' }
daemonize ENV.fetch("DAEMONIZE") { 'true' }

app_dir = File.expand_path("../..", __FILE__)
# shared directory
shared_dir = "#{app_dir}/tmp"
# Set up socket location
bind "unix://#{shared_dir}/sockets/puma.sock"
# Set master PID and state locations
pidfile "#{shared_dir}/pids/puma.pid"
# pidfile "/home/deploy/sgpe/shared/tmp/pids/puma.pid"
state_path "#{shared_dir}/pids/puma.state"
# state_path "/home/deploy/sgpe/shared/tmp/sockets/puma.state"
activate_control_app "unix://#{shared_dir}/sockets/pumactl.sock"
# app directory

# prune_bundler
# threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
# threads threads_count, threads_count
# port        ENV.fetch("PORT") { 3000 }
# environment ENV.fetch("RAILS_ENV") { "development" }
# plugin :tmp_restart
