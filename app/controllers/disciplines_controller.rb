class DisciplinesController < ApplicationController
  before_action :set_discipline, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource
  responders :flash

  add_breadcrumb (I18n.t "helpers.links.pages.#{controller_name}", default: controller_name), :disciplines_path

  # GET /disciplines
  # GET /disciplines.json
  def index
    # @disciplines = Discipline.all
    respond_to do |format|
      format.html
      format.json { render json: DisciplineDatatable.new(view_context) }
    end
  end

  def sortable_columns
    ["id", "title", "sigla", "active"]
  end

  def sort_column
    sortable_columns.include?(params[:column]) ? params[:column] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  # GET /disciplines/1
  # GET /disciplines/1.json
  def show
  end

  # GET /disciplines/new
  def new
    @discipline = Discipline.new
  end

  # GET /disciplines/1/edit
  def edit
  end

  # POST /disciplines
  # POST /disciplines.json
  def create
    @discipline = Discipline.new(discipline_params)
    @discipline.user = current_user

    respond_to do |format|
      if @discipline.save
        format.html { redirect_to @discipline, notice: t('flash.actions.create.notice', resource_name: controller_name.classify.constantize.model_name.human) }
        format.json { render :show, status: :created, location: @discipline }
      else
        format.html { render :new }
        format.json { render json: @discipline.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /disciplines/1
  # PATCH/PUT /disciplines/1.json
  def update
    respond_to do |format|
      @discipline.user = current_user
      if @discipline.update(discipline_params)
        format.html { redirect_to @discipline, notice: t('flash.actions.update.notice', resource_name: controller_name.classify.constantize.model_name.human) }
        format.json { render :show, status: :ok, location: @discipline }
      else
        format.html { render :edit }
        format.json { render json: @discipline.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /disciplines/1
  # DELETE /disciplines/1.json
  def destroy
    @discipline.destroy
    respond_to do |format|
      format.html { redirect_to disciplines_url, notice: t('flash.actions.destroy.notice', resource_name: controller_name.classify.constantize.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discipline
      @discipline = Discipline.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def discipline_params
      params.require(:discipline).permit(:title, :sigla, :active, :user_id, :especial)
    end
end
