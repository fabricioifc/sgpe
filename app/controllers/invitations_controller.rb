# class InvitationsController < Devise::InvitationsController

#   before_action :update_sanitized_params

#   # PUT /resource/invitation
#   def update
    
#     binding.pry
    
#     respond_to do |format|
#       format.js do
#         invitation_token = Devise.token_generator.digest(resource_class, :invitation_token, update_resource_params[:invitation_token])
#         self.resource = resource_class.where(invitation_token: invitation_token).first
#         resource.skip_password = true
#         resource.update_attributes update_resource_params.except(:invitation_token)
#       end
#       format.html do
#         super
#       end
#     end
#   end


#   protected

#   def update_sanitized_params
#     binding.pry
#     devise_parameter_sanitizer.permit(:accept_invitation, keys: [:username, :email, :name, :password, :password_confirmation, :invitation_token, :avatar, :perfils, :perfil_ids => []])
#   end
# end
