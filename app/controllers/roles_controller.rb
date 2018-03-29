class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :admin_only
  load_and_authorize_resource
  responders :flash

  # add_breadcrumb (I18n.t "helpers.links.pages.#{controller_name}", default: controller_name), :roles_path

  # GET /roles
  # GET /roles.json
  def index
    # @roles = Role.all
    respond_to do |format|
      format.html
      format.json { render json: RoleDatatable.new(view_context) }
    end
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
  end

  # GET /roles/new
  def new
    @role = Role.new
  end

  # GET /roles/1/edit
  def edit
  end

  # POST /roles
  # POST /roles.json
  def create
    @role = Role.new(role_params)

    respond_to do |format|
      if @role.save
        format.html { redirect_to roles_path, notice: t('flash.actions.create.notice', resource_name: controller_name.classify.constantize.model_name.human) }
        format.json { render :index, status: :created, location: @role }
      else
        format.html { render :new }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update
    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to roles_path, notice: t('flash.actions.update.notice', resource_name: controller_name.classify.constantize.model_name.human) }
        format.json { render :index, status: :ok, location: @role }
      else
        format.html { render :edit }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    @role.destroy
    respond_to do |format|
      format.html { redirect_to roles_url, notice: t('flash.actions.destroy.notice', resource_name: controller_name.classify.constantize.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit(:name, :resource_type, :resource_id)
    end

    def admin_only
      unless current_user.admin?
        redirect_to root_path, :alert => "Acesso negado. Você não tem permissão para acessar este recurso."
      end
    end

end
