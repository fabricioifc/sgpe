class CourseFormatsController < ApplicationController
  before_action :set_course_format, only: [:show, :edit, :update, :destroy]

  # GET /course_formats
  # GET /course_formats.json
  def index
    # @course_formats = CourseFormat.all
    respond_to do |format|
      format.html
      format.json { render json: CourseFormatDatatable.new(view_context) }
    end
  end

  # GET /course_formats/1
  # GET /course_formats/1.json
  def show
  end

  # GET /course_formats/new
  def new
    @course_format = CourseFormat.new
  end

  # GET /course_formats/1/edit
  def edit
  end

  # POST /course_formats
  # POST /course_formats.json
  def create
    @course_format = CourseFormat.new(course_format_params)

    respond_to do |format|
      if @course_format.save
        format.html { redirect_to course_formats_path, notice: 'Course format was successfully created.' }
        format.json { render :index, status: :created, location: course_formats_path }
        # format.html { redirect_to @course_format, notice: 'Course format was successfully created.' }
        # format.json { render :show, status: :created, location: @course_format }
      else
        format.html { render :new }
        format.json { render json: @course_format.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_formats/1
  # PATCH/PUT /course_formats/1.json
  def update
    respond_to do |format|
      if @course_format.update(course_format_params)
        format.html { redirect_to course_formats_path, notice: 'Course format was successfully created.' }
        format.json { render :index, status: :created, location: course_formats_path }
        # format.html { redirect_to @course_format, notice: 'Course format was successfully updated.' }
        # format.json { render :show, status: :ok, location: @course_format }
      else
        format.html { render :edit }
        format.json { render json: @course_format.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_formats/1
  # DELETE /course_formats/1.json
  def destroy
    @course_format.destroy
    respond_to do |format|
      format.html { redirect_to course_formats_url, notice: 'Course format was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_format
      @course_format = CourseFormat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_format_params
      params.require(:course_format).permit(:name)
    end
end
