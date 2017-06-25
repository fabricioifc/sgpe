class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Redireciona quando o usuário não tiver permissão na página
  # rescue_from CanCan::AccessDenied do |exception|
  #   respond_to do |format|
  #     format.json { head :forbidden, content_type: 'text/html' }
  #     format.html { redirect_to main_app.root_url, notice: exception.message }
  #     format.js   { head :forbidden, content_type: 'text/html' }
  #   end
  # end
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to exception.redirect_path, :alert => exception.message
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar, :avatar_cache, :remove_avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :avatar, :avatar_cache, :remove_avatar])
  end

end
