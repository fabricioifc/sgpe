class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  before_action :load_cursos
  before_action :load_professores
  before_action :load_grades#, except: [:show, :create, :index]

  # GET /offers
  # GET /offers.json
  def index
    # @offers = Offer.all
    respond_to do |format|
      format.html
      format.json { render json: OfferDatatable.new(view_context) }
    end
  end

  # GET /offers/1
  # GET /offers/1.json
  def show
  end

  # GET /offers/new
  def new
    @offer = Offer.new
  end

  # GET /offers/1/edit
  def edit
    params[:grid_id] = "#{@offer.grid_id}
      _#{@offer.year_base unless @offer.year_base.nil?}
      _#{@offer.semestre_base unless @offer.semestre_base.nil?}"
  end

  def teachers
    binding.pry
  end

  # POST /offers
  # POST /offers.json
  def create
    @offer = Offer.new(offer_params)
    @offer.grid_id = params[:grid_id].split('_')[0]
    @offer.year_base = params[:grid_id].split('_')[1]
    @offer.semestre_base = params[:grid_id].split('_')[2]

    respond_to do |format|
      if !@offer.nil? && @offer.valid?
        if @offer.offer_disciplines.empty?
          carregar_disciplinas_grade
          @offer.offer_disciplines = []
          @grid_disciplines.each do |g|
            @offer.offer_disciplines << OfferDiscipline.new(grid_discipline: g, user:nil)
          end
          format.html { render :new }
        elsif @offer.save
          format.html { redirect_to @offer, notice: 'Offer was successfully created.' }
          format.json { render :show, status: :created, location: @offer }
        else
          format.html { render :new }
          format.json { render json: @offer.errors, status: :unprocessable_entity }
        end
      else
        carregar_disciplinas_grade

        format.html { render :new }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offers/1
  # PATCH/PUT /offers/1.json
  def update
    binding.pry
    respond_to do |format|
      if @offer.update(offer_params)
        format.html { redirect_to @offer, notice: 'Offer was successfully updated.' }
        format.json { render :show, status: :ok, location: @offer }
      else
        format.html { render :edit }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offers/1
  # DELETE /offers/1.json
  def destroy
    @offer.destroy
    respond_to do |format|
      format.html { redirect_to offers_url, notice: 'Offer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def load_grid
    carregar_disciplinas_grade

    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer
      @offer = Offer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offer_params
      params.require(:offer).permit(:year, :semestre, :type_offer, :grid_id,
      offer_disciplines_attributes: [:id, :grid_discipline_id, :user_id, :active, :offer_id, :_destroy])
    end

    def load_cursos
      @cursos = Course.where(active:true)
    end

    def load_professores
      @professores = User.where(teacher:true).order(:name)
    end

    def carregar_disciplinas_grade

      if !params[:grid_id].blank?
        grid_id = params[:grid_id].split('_')[0]
        ano = params[:grid_id].split('_')[1]
        semestre = params[:grid_id].split('_')[2]

        @grid = Grid.find(grid_id)
        @grid_disciplines = []

        if !ano.nil?
          @grid_anos = GridDiscipline.joins(:grid).where(:year => ano).where(grid_id:grid_id)
          # @grid = Grid.joins(:grid_disciplines).where('grids.id = ?', grid_id).where(:grid_disciplines => {:year => ano.to_i})
        elsif !semestre.nil?
          @grid_semestres = GridDiscipline.joins(:grid).where(:semestre => semestre).where(grid_id:grid_id)
          # @grid = Grid.joins(:grid_disciplines => :discipline).
          #   where(id: grid_id).
          #   where('grid_disciplines.semestre = ?', semestre).uniq
        end

        @grid_disciplines = @grid_disciplines + @grid_anos unless @grid_anos.nil? || @grid_anos.empty?
        @grid_disciplines = @grid_disciplines + @grid_semestres unless @grid_semestres.nil? || @grid_semestres.empty?

        if !@offer.nil?
          if @offer.offer_disciplines.empty?
            @offer.offer_disciplines = []
          end
        end

      end

    end

    def load_grades
      @grades = Grid.includes(:course).
        joins(:grid_disciplines => :discipline).
        order('grid_disciplines.year', 'grid_disciplines.semestre').
        pluck('id', 'grid_disciplines.year', 'grid_disciplines.semestre', 'courses.name', 'year').uniq
    end
end
