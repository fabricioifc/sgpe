class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :prepare_exception_notifier

  # load_and_authorize_resource unless: :devise_controller?
  before_action do fix_carrega_permissoes end

  around_action :rescue_from_fk_contraint, only: [:destroy]

  rescue_from ActiveRecord::RecordNotFound do |exception|
    respond_to do |format|
      flash[:warning] = "Página/Recurso não encontrado. #{exception.message}"
      format.html { redirect_to root_path }
      # format.html { redirect_to send("#{controller_name}_path") }
    end
  end

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

  # def add_current_breadcrumb
    # add_breadcrumb "Inicio", :root_path
    # add_breadcrumb (t "helpers.links.pages.#{controller_name}", default: controller_name), "#{url_for(:only_path => false)}"
  # end

end
