class CreateAdminService
  def call
    # Administrador do sistema
    user = User.find_or_create_by(email: Rails.application.secrets.admin_email) do |user|
      user.username                   = Rails.application.secrets.admin_email.split('@')[0]
      user.name                   = Rails.application.secrets.admin_name
      user.password               = Rails.application.secrets.admin_password
      user.password_confirmation  = Rails.application.secrets.admin_password
      user.admin                  = true
      user.confirm
    end
  end
end
