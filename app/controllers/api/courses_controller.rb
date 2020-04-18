# class Api::CoursesController < Api::BaseController
#     before_action :authenticate_user!
#     #   load_and_authorize_resource :except => [:index]
#         # skip_before_action :authenticate_user, only: [:index], raise: false
    
#     def index
#         @courses = Course.all
#         respond_to do |format|
#             format.json { render json: @courses }
#         end
#     end
# end