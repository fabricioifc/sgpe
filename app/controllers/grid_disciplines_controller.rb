class GridDisciplinesController < ApplicationController
  before_action :set_grid_discipline, only: [:show, :edit, :update, :destroy]

  # GET /grid_disciplines
  # GET /grid_disciplines.json
  def index
    @grid_disciplines = GridDiscipline.all
  end

  # GET /grid_disciplines/1
  # GET /grid_disciplines/1.json
  def show
  end

  # GET /grid_disciplines/new
  def new
    @grid_discipline = GridDiscipline.new
  end

  # GET /grid_disciplines/1/edit
  def edit
  end

  # POST /grid_disciplines
  # POST /grid_disciplines.json
  def create
    @grid_discipline = GridDiscipline.new(grid_discipline_params)

    respond_to do |format|
      if @grid_discipline.save
        format.html { redirect_to @grid_discipline, notice: 'Grid discipline was successfully created.' }
        format.json { render :show, status: :created, location: @grid_discipline }
      else
        format.html { render :new }
        format.json { render json: @grid_discipline.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grid_disciplines/1
  # PATCH/PUT /grid_disciplines/1.json
  def update
    respond_to do |format|
      if @grid_discipline.update(grid_discipline_params)
        format.html { redirect_to @grid_discipline, notice: 'Grid discipline was successfully updated.' }
        format.json { render :show, status: :ok, location: @grid_discipline }
      else
        format.html { render :edit }
        format.json { render json: @grid_discipline.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grid_disciplines/1
  # DELETE /grid_disciplines/1.json
  def destroy
    @grid_discipline.destroy
    respond_to do |format|
      format.html { redirect_to grid_disciplines_url, notice: 'Grid discipline was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grid_discipline
      @grid_discipline = GridDiscipline.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grid_discipline_params
      params.require(:grid_discipline).permit(:year, :ementa, :objetivo_geral, :bib_geral, :bib_espec, :grid_id, :discipline_id)
    end
end
