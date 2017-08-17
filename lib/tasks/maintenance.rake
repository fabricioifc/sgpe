# namespace :maintenance do
#   MAINTENANCE_FILE = Rails.root.join("public/system/maintenance.html")
#   RESTART_FILE = Rails.root.join("tmp/restart")
#
#   desc "Start the maintenance mode"
#   task :enable => :environment do
#     if !File.exists?(MAINTENANCE_FILE)
#       dir = File.dirname(MAINTENANCE_FILE)
#       system "mkdir -p #{dir} && echo \"Website is on maintenance. We’ll be back in a few seconds...\" > #{MAINTENANCE_FILE}"
#       Rails.logger.info("[MAINTENANCE] App is now DOWN")
#     end
#   end
#
#   desc "Stop the maintenance mode"
#   task :disable => :environment do
#     if File.exists?(MAINTENANCE_FILE)
#       if File.unlink(MAINTENANCE_FILE) == 1
#         Rails.logger.info("[MAINTENANCE] App is now UP")
#       end
#     end
#   end
#
#   desc "Restart the application"
#   task :restart => :environment do
#     FileUtils.touch(RESTART_FILE)
#     Rails.logger.info("[MAINTENANCE] App has restarted")
#   end
#
# end
