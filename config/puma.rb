if ENV.fetch("RAILS_ENV") == 'production'
	port        ENV.fetch("PORT") { 3000 }

	environment ENV.fetch("RAILS_ENV") { "production" }

	bind  "unix:///home/deploy/sgpe/shared/tmp/sockets/puma.sock"
	pidfile "/home/deploy/sgpe/shared/tmp/pids/puma.pid"
	state_path "/home/deploy/sgpe/shared/tmp/sockets/puma.state"
	directory "/home/deploy/sgpe/current"

	workers 2
	threads 1,2

	daemonize true

	activate_control_app 'unix:///home/deploy/sgpe/shared/tmp/sockets/pumactl.sock'

	prune_bundler

else
	threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
	threads threads_count, threads_count
	port        ENV.fetch("PORT") { 3000 }
	environment ENV.fetch("RAILS_ENV") { "development" }
	plugin :tmp_restart
end