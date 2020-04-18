class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  # respond_to :json
  protect_from_forgery unless: -> { request.format.json? }
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :prepare_exception_notifier
  before_action :dont_allow_user_self_registration
  
  # acts_as_token_authentication_handler_for User
  acts_as_token_authentication_handler_for User, fallback_to_devise: false

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
      # format.json { head :forbidden, content_type: 'text/json' }
      format.json {
        render :json => {:error => exception.message}, :status => :forbidden, content_type: 'text/json', head: :forbidden
      }
      format.html { redirect_to main_app.root_url, alert: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  add_breadcrumb "Inicio", :root_path
  before_action :adicionar_breadcrumb_show

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,           keys: [:username, :email, :name, :siape, :bio, :teacher, :avatar, :avatar_cache, :remove_avatar, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:sign_in,           keys: [:login, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update,    keys: [:login, :username, :email, :name, :siape, :bio, :teacher, :avatar, :avatar_cache, :remove_avatar, :password, :password_confirmation, :current_password])
    devise_parameter_sanitizer.permit(:invite,            keys: [:username, :email, :name, :siape, :invitation_token, :avatar, :avatar_cache, :perfils, :perfil_ids => []])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:username, :name, :password, :siape, :password_confirmation, :invitation_token, :avatar, :avatar_cache, :perfils, :perfil_ids => []])
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

  protected

  def authenticate_user!
    if request.headers['Authorization'].present?
      authenticate_or_request_with_http_token do |token|
        begin
          # login = request.headers['X-User-Email']
          @current_user = User.find_by(authentication_token: token)
        rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
          head :unauthorized
        end
      end
    end
  end

  # def after_sign_in_path_for(resource)
  #   # request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  #   # if is_professor?
  #   #   planos_professor_path
  #   # end
  # end

  private

  def prepare_exception_notifier
    request.env["exception_notifier.exception_data"] = {
      :current_user => current_user
    }
  end

  def dont_allow_user_self_registration
    if ['devise/registrations','devise_invitable/registrations'].include?(params[:controller]) && ['new','create'].include?(params[:action])
      flash[:warning] = 'A sua inscrição pode ser feita apenas através de convite.'
      redirect_to root_path
    end
  end

  def authenticate_inviter!
    unless user_signed_in? && (can? :manage, User)
      redirect_to root_url, :alert => "Acesso negado! Você não tem permissão para acessar este recurso."
    end
    super
  end

  # def add_current_breadcrumb
    # add_breadcrumb "Inicio", :root_path
    # add_breadcrumb (t "helpers.links.pages.#{controller_name}", default: controller_name), "#{url_for(:only_path => false)}"
  # end

  def adicionar_breadcrumb_show
    # binding.pry
    unless ['plans', 'registrations', 'pages', 'invitations', 'users'].include?(controller_name)
      if ['offers'].include?(controller_name) && ['pesquisar'].include?(action_name)
        return
      end
      add_breadcrumb (I18n.t "helpers.links.pages.#{controller_name}", default: controller_name), "#{controller_name.pluralize}_path".to_sym, :only => %w(index)
      if ['edit', 'show'].include?(action_name)
        add_breadcrumb 'Editar', "edit_#{controller_name.singularize}_path".to_sym, :only => %w(edit show)
      end
    end
  end

  def is_professor?
    user_signed_in? && (current_user.try(:teacher?) || current_user.perfils.pluck('UPPER(name)').include?('PROFESSOR') )
  end

  # def after_sign_in_path_for(resource)
  #   # resource.authentication_token = nil
  #   signed_in_root_path(resource)
  # end

end
