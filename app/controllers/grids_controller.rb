class GridsController < ApplicationController
  before_action :set_grid, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  before_action :load_cursos_ativos
  before_action :load_disciplinas

  # GET /grids
  # GET /grids.json
  def index
    # @grids = Grid.all
    respond_to do |format|
      format.html
      format.json { render json: GridDatatable.new(view_context) }
    end
  end

  # GET /grids/1
  # GET /grids/1.json
  def show
  end

  # GET /grids/new
  def new
    @grid = Grid.new
    @grid.grid_disciplines.build
  end

  # GET /grids/1/edit
  def edit
  end

  # POST /grids
  # POST /grids.json
  def create
    @grid = Grid.new(grid_params)
    @grid.user = current_user
    binding.pry

    respond_to do |format|
      if @grid.save
        format.html { redirect_to @grid, notice: 'Grid was successfully created.' }
        format.json { render :show, status: :created, location: @grid }
      else
        format.html { render :new }
        format.json { render json: @grid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grids/1
  # PATCH/PUT /grids/1.json
  def update
    respond_to do |format|
      if @grid.update(grid_params)
        format.html { redirect_to @grid, notice: 'Grid was successfully updated.' }
        format.json { render :show, status: :ok, location: @grid }
      else
        format.html { render :edit }
        format.json { render json: @grid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grids/1
  # DELETE /grids/1.json
  def destroy
    @grid.destroy
    respond_to do |format|
      format.html { redirect_to grids_url, notice: 'Grid was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grid
      @grid = Grid.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grid_params
      params.require(:grid).permit(:year, :active, :course_id, :user_id,
        grid_disciplines_attributes: [:year, :ementa, :objetivo_geral, :bib_geral, :bib_espec, :discipline_id]
      )
    end

    def load_cursos_ativos
      @cursos = Course.where(active:true)
    end

    def load_disciplinas
      @disciplinas = Discipline.all
    end
end
