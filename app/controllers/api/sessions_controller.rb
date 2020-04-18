class Api::SessionsController < Api::BaseController
  
  before_action :require_login!, except: :create
  before_action :sign_in_params, only: :create
  # skip_before_action :authenticate_entity_from_token!, only: [:create]
  skip_before_action :authenticate_user, only: [:create], raise: false
  # skip_before_action :authenticate_entity!, only: [:create]
  # skip_before_action :verify_authenticity_token
  # before_action :ensure_params_exist

  # POST /users/sign_in
  def create
    resource = User.find_for_database_authentication(:login=>params[:sign_in_params][:login])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:sign_in_params][:password])
      resource.generate_auth_token
      sign_in("user", resource)
      render :json=> {
        :success=>true, 
        :auth_token=>resource.authentication_token, 
        :login=>resource.username, 
        :email=>resource.email, 
        id: resource.id, 
        name: resource.name,
        role: resource.perfils.pluck(:name),
        admin: resource.admin,
        avatar: (rails_blob_path(resource.avatar) if resource.avatar.attached?)
      }
      return
    end
    invalid_login_attempt
  end

  # DELETE /users/sign_out
  def destroy
    resource = current_user
    resource.invalidate_auth_token
    head :ok
  end

  protected
  def ensure_params_exist
    return unless params[:sign_in_params].blank?
    render :json=>{:success=>false, :message=>"missing user_login parameter"}, :status=>422
  end

  def invalid_login_attempt
    warden.custom_failure!
    # render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
    render json: {
      messages: "Signed In Failed - Unauthorized",
      success: false,
      data: {}
    }, status: :unauthorized
  end

  private
  def invalid_login_attempt
    render json: { errors: [ { detail:"Error with your login or password" }]}, status: 401
  end

  def sign_in_params
    params.fetch(:sign_in_params).permit([:password, :login])
  end

  def reset_token(resource)
    resource.authentication_token = nil
    resource.save!
  end

  def after_successful_token_authentication
    # Make the authentication token to be disposable - for example
    renew_authentication_token!
  end
end