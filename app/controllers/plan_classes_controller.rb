class PlanClassesController < ApplicationController
  before_action :set_plan_class, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /plan_classes
  # GET /plan_classes.json
  def index
    # @plan_classes = PlanClass.all
    respond_to do |format|
      format.html
      format.json { render json: PlanClassDatatable.new(view_context) }
    end
  end

  # GET /plan_classes/1
  # GET /plan_classes/1.json
  def show
  end

  # GET /plan_classes/new
  def new
    @plan_class = PlanClass.new
  end

  # GET /plan_classes/1/edit
  def edit
  end

  # POST /plan_classes
  # POST /plan_classes.json
  def create
    @plan_class = PlanClass.new(plan_class_params)

    respond_to do |format|
      if @plan_class.save
        format.html { redirect_to @plan_class, notice: 'Plan class was successfully created.' }
        format.json { render :show, status: :created, location: @plan_class }
      else
        format.html { render :new }
        format.json { render json: @plan_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plan_classes/1
  # PATCH/PUT /plan_classes/1.json
  def update
    respond_to do |format|
      if @plan_class.update(plan_class_params)
        format.html { redirect_to @plan_class, notice: 'Plan class was successfully updated.' }
        format.json { render :show, status: :ok, location: @plan_class }
      else
        format.html { render :edit }
        format.json { render json: @plan_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plan_classes/1
  # DELETE /plan_classes/1.json
  def destroy
    @plan_class.destroy
    respond_to do |format|
      format.html { redirect_to plan_classes_url, notice: 'Plan class was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan_class
      @plan_class = PlanClass.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_class_params
      params.require(:plan_class).permit(:name, :ano, :active)
    end
end
