class PerfilRolesController < ApplicationController
  before_action :set_perfil_role, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :admin_only
  load_and_authorize_resource
  responders :flash

  # add_breadcrumb (I18n.t "helpers.links.pages.#{controller_name}", default: controller_name), :roles_path

  # GET /perfil_roles
  # GET /perfil_roles.json
  def index
    # @perfil_roles = PerfilRole.all
    respond_to do |format|
      format.html
      format.json { render json: PerfilRoleDatatable.new(view_context) }
    end
  end

  # GET /perfil_roles/1
  # GET /perfil_roles/1.json
  # def show
  # end

  # GET /perfil_roles/new
  def new
    @perfil_role = PerfilRole.new
  end

  # GET /perfil_roles/1/edit
  def edit
  end

  # POST /perfil_roles
  # POST /perfil_roles.json
  def create
    @perfil_role = PerfilRole.new(perfil_role_params)

    respond_to do |format|
      if @perfil_role.save
        format.html { redirect_to perfil_roles_url, notice: t('flash.actions.create.notice', resource_name: controller_name.classify.constantize.model_name.human) }
        format.json { render :index, status: :created, location: @perfil_role }
      else
        format.html { render :new }
        format.json { render json: @perfil_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /perfil_roles/1
  # PATCH/PUT /perfil_roles/1.json
  def update
    respond_to do |format|
      if @perfil_role.update(perfil_role_params)
        format.html { redirect_to perfil_roles_url, notice: t('flash.actions.update.notice', resource_name: controller_name.classify.constantize.model_name.human) }
        format.json { render :index, status: :ok, location: @perfil_role }
      else
        format.html { render :edit }
        format.json { render json: @perfil_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /perfil_roles/1
  # DELETE /perfil_roles/1.json
  def destroy
    @perfil_role.destroy
    respond_to do |format|
      format.html { redirect_to perfil_roles_url, notice: t('flash.actions.destroy.notice', resource_name: controller_name.classify.constantize.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_perfil_role
      @perfil_role = PerfilRole.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def perfil_role_params
      params.require(:perfil_role).permit(:perfil_id, :role_id)
    end

    def admin_only
      unless current_user.admin?
        redirect_to root_path, :alert => "Acesso negado. Você não tem permissão para acessar este recurso."
      end
    end
end
