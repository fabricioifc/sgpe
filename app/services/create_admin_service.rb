class CreateAdminService
  def call
    user = User.find_or_create_by(
        email: Rails.application.secrets.admin_email,
        name:  Rails.application.secrets.admin_name,
        username:  Rails.application.secrets.admin_username,
      ) do |user|
      user.password               = Rails.application.secrets.admin_password
      user.password_confirmation  = Rails.application.secrets.admin_password
      user.admin                  = true
      user.confirm
    end
  end
end
