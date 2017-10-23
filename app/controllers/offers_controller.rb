class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  before_action :load_cursos
  before_action :load_professores
  before_action :load_grades

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
    params[:grid_id] = @offer.grid_id
    params[:grid_year] = @offer.year_base
    params[:grid_semestre] = @offer.semestre_base

    @grade_anos = load_grade_anos(params[:grid_id])
    @grade_semestres = load_grade_semestres(params[:grid_id])
  end

  # POST /offers
  # POST /offers.json
  def create
    @offer = Offer.new(offer_params)
    salvar_atualizar(true)
  end

  # PATCH/PUT /offers/1
  # PATCH/PUT /offers/1.json
  def update
    salvar_atualizar(false)
    # respond_to do |format|
    #   if @offer.update(offer_params)
    #     format.html { redirect_to @offer, notice: 'Offer was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @offer }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @offer.errors, status: :unprocessable_entity }
    #   end
    # end
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
    if !params[:grid_id].nil? && !params[:grid_id].blank?
      if params[:grid_year].nil? && params[:grid_semestre].nil?
        @grade_anos = load_grade_anos(params[:grid_id])
        @grade_semestres = load_grade_semestres(params[:grid_id])
      else
        carregar_disciplinas_grade
      end
    end

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
        grid_id = params[:grid_id]
        ano = params[:grid_year]
        semestre = params[:grid_semestre]


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

      @grid_disciplines

    end

    def load_grades
      @grades = Grid.includes(:course).
        joins(:grid_disciplines => :discipline).
        order('grid_disciplines.year', 'grid_disciplines.semestre').
        pluck('id', 'grid_disciplines.year', 'grid_disciplines.semestre', 'courses.name', 'year').uniq
    end

    def load_grade_anos(grid_id)
      if !grid_id.nil? && !grid_id.blank?
        Grid.joins(:grid_disciplines => :discipline).
          where('grids.id = ? and grid_disciplines.year is not null', grid_id).
          pluck('grid_disciplines.year').uniq
      end
    end

    def load_grade_semestres(grid_id)
      if !grid_id.nil? && !grid_id.blank?
        Grid.joins(:grid_disciplines => :discipline).
          where('grids.id = ? and grid_disciplines.semestre is not null', grid_id).
          pluck('grid_disciplines.semestre').uniq
      end
    end

    def salvar_atualizar(novo = true)
      @offer.grid_id = params[:grid_id]
      @offer.year_base = params[:grid_year]
      @offer.semestre_base = params[:grid_semestre]

      @grade_anos = load_grade_anos(params[:grid_id])
      @grade_semestres = load_grade_semestres(params[:grid_id])

      respond_to do |format|
        if !@offer.nil? && @offer.valid?
          if @offer.offer_disciplines.empty?
            carregar_disciplinas_grade
            @offer.offer_disciplines = []
            @grid_disciplines.each do |g|
              @offer.offer_disciplines << OfferDiscipline.new(grid_discipline: g, user:nil)
            end
            format.html { render :new } if novo
            format.html { render :edit } unless novo
          elsif novo && @offer.save
              format.html { redirect_to @offer, notice: 'Offer was successfully created.' }
              format.json { render :show, status: :created, location: @offer }
          elsif !novo && @offer.update(offer_params)
            format.html { redirect_to @offer, notice: 'Offer was successfully updated.' }
            format.json { render :show, status: :ok, location: @offer }
          else
            format.html { render :new } if novo
            format.html { render :edit } unless novo
            format.json { render json: @offer.errors, status: :unprocessable_entity }
          end
        else
          @grid_disciplines = carregar_disciplinas_grade

          format.html { render :new } if novo
          format.html { render :edit } unless novo
          format.json { render json: @offer.errors, status: :unprocessable_entity }
        end
      end

    end
end
