class NewsletterJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "I am busy mailing newsletter."
  end
end
