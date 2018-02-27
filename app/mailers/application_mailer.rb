class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.secrets.admin_email
  layout 'mailer'

end
