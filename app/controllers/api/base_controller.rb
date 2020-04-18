class Api::BaseController < ApplicationController
  # def authenticate_user!
  #   binding.pry
  #   if request.headers['Authorization'].present?
  #     authenticate_or_request_with_http_token do |token|
  #       begin
  #         jwt_payload = JWT.decode(token, Rails.application.secrets.secret_key_base).first

  #         @current_user_id = jwt_payload['id']
  #       rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
  #         head :unauthorized
  #       end
  #     end
  #   end
  # end

  # def authenticate_user!
  #   authenticate_or_request_with_http_token do |token, _options|
  #     @current_user  ||= User.find_by(authentication_token: token)
  #   end
  # end

  # def current_user
  #   @current_user ||= authenticate
  # end

  # before_action :require_login!
  # helper_method :person_signed_in?, :current_user

  # def user_signed_in?
  #   current_person.present?
  # end

  # def require_login!
  #   binding.pry
  #   return true if authenticate_token
  #   render json: { errors: [ { detail: "Access denied" } ] }, status: 401
  # end

  # def current_user
  #   @_current_user ||= authenticate_token
  # end

  # private
  # def authenticate_token
  #   authenticate_with_http_token do |token, options|
  #     User.find_by(authentication_token: token)
  #   end
  # end
  # respond_to :json

  # # acts_as_token_authentication_handler_for User, fallback_to_devise: false

  # before_action :authenticate

  # private

  # def authenticate
  #   authenticate_or_request_with_http_token do |token, _options|
  #     print(token)
      
  #     User.find_by(authentication_token: token)
  #   end
  # end

  # def current_user
  #   @current_user ||= authenticate
  # end
end