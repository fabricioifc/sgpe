# Change to match your CPU core count
workers 2
# Min and Max threads per worker
threads 1, 6
# root directory

# Caso esteja no ambiente de produção ou aprovação
if ['production','staging'].include? ENV['RAILS_ENV']
  environment ENV["ENVIRONMENT"]
  port  ENV["PORT"]
  daemonize ENV["DAEMONIZE"]
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
#  stdout_redirect "#{shared_dir}/shared/log/stdout", "#{shared_dir}/shared/log/stderr"
else
  threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
  threads threads_count, threads_count
  port        ENV.fetch("PORT") { 8080 }
  environment ENV.fetch("RAILS_ENV") { "development" }
  plugin :tmp_restart
end
