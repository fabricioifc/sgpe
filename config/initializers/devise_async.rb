if Rails.env.production?
  Devise::Async.setup do |config|
    config.enabled = true
  end
end
