class CourseModalitiesController < ApplicationController
  before_action :set_course_modality, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  add_breadcrumb (I18n.t "helpers.links.pages.#{controller_name}", default: controller_name), :course_modalities_path

  # GET /course_modalities
  # GET /course_modalities.json
  def index
    # @course_modalities = CourseModality.all
    respond_to do |format|
      format.html
      format.json { render json: CourseModalityDatatable.new(view_context) }
    end
  end

  # GET /course_modalities/1
  # GET /course_modalities/1.json
  def show
  end

  # GET /course_modalities/new
  def new
    @course_modality = CourseModality.new
  end

  # GET /course_modalities/1/edit
  def edit
  end

  # POST /course_modalities
  # POST /course_modalities.json
  def create
    @course_modality = CourseModality.new(course_modality_params)

    respond_to do |format|
      if @course_modality.save
        format.html { redirect_to course_modalities_path, notice: t('flash.actions.create.notice', resource_name: controller_name.classify.constantize.model_name.human) }
        format.json { render :index, status: :created, location: @course_modality }
      else
        format.html { render :new }
        format.json { render json: @course_modality.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_modalities/1
  # PATCH/PUT /course_modalities/1.json
  def update
    respond_to do |format|
      if @course_modality.update(course_modality_params)
        format.html { redirect_to @course_modality, notice: 'Course modality was successfully updated.' }
        format.json { render :show, status: :ok, location: @course_modality }
      else
        format.html { render :edit }
        format.json { render json: @course_modality.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_modalities/1
  # DELETE /course_modalities/1.json
  def destroy
    @course_modality.destroy
    respond_to do |format|
      format.html { redirect_to course_modalities_url, notice: 'Course modality was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_modality
      @course_modality = CourseModality.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_modality_params
      params.require(:course_modality).permit(:sigla, :description)
    end
end
