if Rails.env.production?
# if ['production','staging'].include? Rails.env
  Rails.application.configure do
    # config.active_job.queue_adapter = :sidekiq
    config.active_job.queue_adapter = :async
  end
end
