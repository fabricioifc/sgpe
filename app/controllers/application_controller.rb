class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :prepare_exception_notifier
  around_action :rescue_from_fk_contraint, only: [:destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # load_and_authorize_resource unless: :devise_controller?
  before_action do fix_carrega_permissoes end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, alert: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  add_breadcrumb "Inicio", :root_path

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,         keys: [:username, :email, :name, :bio, :teacher, :avatar, :avatar_cache, :remove_avatar, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:sign_in,         keys: [:login, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update,  keys: [:username, :email, :name, :bio, :teacher, :avatar, :avatar_cache, :remove_avatar, :password, :password_confirmation, :current_password])
  end

  def fix_carrega_permissoes
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  def rescue_from_fk_contraint
    begin
      yield
    rescue ActiveRecord::InvalidForeignKey
      respond_to do |format|
        flash[:alert] = 'Não foi possível excluir este ítem. Existem registros vinculados.'
        format.html { redirect_to url_for(request.path) }
      end
      # Flash and render, render API json error... whatever
    end
  end

  private

  def prepare_exception_notifier
    request.env["exception_notifier.exception_data"] = {
      :current_user => current_user
    }
  end

  def record_not_found
    # render file: "#{Rails.root}/public/404", layout: true, status: :not_found
    respond_to do |format|
      flash[:warning] = 'Recurso não encontrado.'
      format.html { redirect_to send("#{controller_name}_path") }
    end
  end

end
