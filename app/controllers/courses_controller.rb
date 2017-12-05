class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  before_action :load_modalidades
  before_action :load_formatos
  before_action :load_ofertas

  add_breadcrumb (I18n.t "helpers.links.pages.#{controller_name}", default: controller_name), :courses_path

  # GET /courses
  # GET /courses.json
  def index
    # @courses = Course.all
    respond_to do |format|
      format.html
      format.json { render json: CourseDatatable.new(view_context) }
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)
    @course.user = current_user

    respond_to do |format|
      if @course.save
        format.html { redirect_to courses_path, notice: t('flash.actions.create.notice', resource_name: controller_name.classify.constantize.model_name.human) }
        format.json { render :index, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to courses_path, notice: 'Course was successfully updated.' }
        format.json { render :index, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :sigla, :active, :course_modality_id, :course_format_id, :course_offer_id, :user_id)
    end

    def load_modalidades
      @modalidades = CourseModality.all
    end

    def load_formatos
      @formatos = CourseFormat.all
    end

    def load_ofertas
      @ofertas = CourseOffer.all
    end
end
