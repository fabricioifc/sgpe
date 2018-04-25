class LessonRecurringsController < ApplicationController
  before_action :set_lesson_recurring, only: [:show, :edit, :update, :destroy]

  # GET /lesson_recurrings
  # GET /lesson_recurrings.json
  def index
    @lesson_recurrings = LessonRecurring.all
  end

  # GET /lesson_recurrings/1
  # GET /lesson_recurrings/1.json
  def show
  end

  # GET /lesson_recurrings/new
  def new
    @lesson_recurring = LessonRecurring.new
  end

  # GET /lesson_recurrings/1/edit
  def edit
  end

  # POST /lesson_recurrings
  # POST /lesson_recurrings.json
  def create
    binding.pry
    @lesson_recurring = LessonRecurring.new(lesson_recurring_params)
    # @lesson_recurring.lessons = []
    # @offer_discipline.each do |od|
    #   @lesson_recurring.lessons << Lesson.new(offer_discipline: od, lesson_recurring: @lesson_recurring)
    # end

    respond_to do |format|
      # if @lesson_recurring.save
      if true == false
        format.html { redirect_to @lesson_recurring, notice: 'Lesson recurring was successfully created.' }
        format.json { render :show, status: :created, location: @lesson_recurring }
      else
        format.html { render :new }
        format.json { render json: @lesson_recurring.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lesson_recurrings/1
  # PATCH/PUT /lesson_recurrings/1.json
  def update
    respond_to do |format|
      if @lesson_recurring.update(lesson_recurring_params)
        format.html { redirect_to @lesson_recurring, notice: 'Lesson recurring was successfully updated.' }
        format.json { render :show, status: :ok, location: @lesson_recurring }
      else
        format.html { render :edit }
        format.json { render json: @lesson_recurring.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lesson_recurrings/1
  # DELETE /lesson_recurrings/1.json
  def destroy
    @lesson_recurring.destroy
    respond_to do |format|
      format.html { redirect_to lesson_recurrings_url, notice: 'Lesson recurring was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def carregar_disciplinas
    # binding.pry
    @offer_disciplines = OfferDiscipline.joins(:grid_discipline => :discipline).where(offer_id: params[:offer_id])
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson_recurring
      @lesson_recurring = LessonRecurring.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_recurring_params
      params.require(:lesson_recurring).permit(:dtinicio, :dtfim, :calendar_id, :turma_id, :offer_id, :active, :dias_selecionados => [], :periodos_selecionados => [])
    end
end
