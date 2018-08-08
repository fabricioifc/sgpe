# Just use the production settings
require File.expand_path('../production.rb', __FILE__)

Rails.application.configure do
  # Here override any defaults
  # config.serve_static_files = true
  # config.active_job.queue_adapter = :async
  # config.action_mailer.delivery_method = :letter_opener
  # config.action_mailer.perform_deliveries = true
end
