class OffersController < ApplicationController
  include PlansHelper

  before_action :set_offer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :ptd_index]
  load_and_authorize_resource :except => [:index, :show, :ptd_index]
  responders :flash

  # add_breadcrumb (I18n.t "helpers.links.pages.#{controller_name}", default: controller_name), :offers_path, :except => %w(pesquisar)

  before_action :load_cursos
  before_action :load_professores
  before_action :load_grades
  before_action :load_formatos

  # GET /offers
  # GET /offers.json
  def index    
    # @offers = Offer.all
    respond_to do |format|
      format.html
      format.json { 
        if params[:draw]
          render json: OfferDatatable.new(view_context) 
        else
          @ofertas = Offer.all.includes(:offer_disciplines => :grid_discipline)
          render :partial => "offers/ofertas.json"
          # render json: Offer.all.includes(:offer_disciplines => :grid_discipline)
        end
      }
    end
  end

  # Exemplo: http://localhost:3000/offers/ptd_index.json?year=2018
  def ptd_index
    year = params[:year]
    semestre = params[:semestre]

    if year.nil?
      @ofertas = Offer.all
    else
      if !year.nil? && !semestre.nil?
        @ofertas = Offer.where(year: params[:year].to_i, semestre: params[:semestre].to_i)
      else
        @ofertas = Offer.where(year: params[:year].to_i)
      end
    end

    @ofertas.includes(:offer_disciplines => :grid_discipline)
    render :partial => "offers/ofertas.json"
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
    params[:minutos_aula] = @offer.minutos_aula
    # parâmetro utilizado para mostrar ou não o segundo professor ao editar
    params[:has_second_user] = @offer.offer_disciplines.where.not(second_user:nil).count > 0

    @grade_anos = load_grade_anos(params[:grid_id])
    @grade_semestres = load_grade_semestres(params[:grid_id])
  end

  # POST /offers
  # POST /offers.json
  def create
    @offer = Offer.new(offer_params)
    @offer.grid_id = params[:grid_id]
    @offer.year_base = params[:grid_year]
    @offer.semestre_base = params[:grid_semestre]
    @offer.minutos_aula = params[:minutos_aula]

    @grade_anos = load_grade_anos(params[:grid_id])
    @grade_semestres = load_grade_semestres(params[:grid_id])

    respond_to do |format|
      if @offer.valid? && @offer.save
        format.html { redirect_to @offer, notice: t('flash.actions.create.notice', resource_name: controller_name.classify.constantize.model_name.human) }
        format.json { render :show, status: :created, location: @offer }
      elsif @offer.offer_disciplines.empty?
        @grid_disciplines = carregar_disciplinas_grade
        @offer.offer_disciplines = []
        @grid_disciplines.each do |g|
          @offer.offer_disciplines << OfferDiscipline.new(grid_discipline: g, user:nil)
        end
        format.html { render :new }
      else
        @grid_disciplines = carregar_disciplinas_grade
        format.html { render :new }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end

    end
  end

  # PATCH/PUT /offers/1
  # PATCH/PUT /offers/1.json
  def update
    begin
      # @offer = Offer.new(offer_params)
      @offer.grid_id = params[:grid_id]
      @offer.year_base = params[:grid_year]
      @offer.semestre_base = params[:grid_semestre]
      @offer.minutos_aula = params[:minutos_aula]
      
      @grade_anos = load_grade_anos(params[:grid_id])
      @grade_semestres = load_grade_semestres(params[:grid_id])

      respond_to do |format|
        if offer_params[:offer_disciplines_attributes].nil? || offer_params[:offer_disciplines_attributes].empty?
          @grid_disciplines = carregar_disciplinas_grade
          @offer.offer_disciplines = []
          @grid_disciplines.each do |g|
            @offer.offer_disciplines << OfferDiscipline.new(grid_discipline: g, user:nil)
          end
          format.html { render :edit }
        else
          ActiveRecord::Base.transaction do
            # offer_params[:offer_disciplines_attributes]
            if @offer.update(offer_params)
              # @offer.offer_disciplines.each do |d|
              #   offer_params[:offer_disciplines_attributes].each do |k,v|
              #     if !v[:id].empty? && v[:id].to_i == d.id
              #       OfferDisciplineTurma.where(offer_discipline_id: d.id).destroy_all
              #       v[:turmas_id].each do |turma|
              #         if !turma.empty?
              #           OfferDisciplineTurma.find_or_create_by!(offer_discipline_id: d.id, turma_id: turma.to_i)
              #         end
              #       end
              #     end
              #   end
              # end
              format.html { redirect_to @offer, notice: t('flash.actions.update.notice', resource_name: controller_name.classify.constantize.model_name.human) }
              format.json { render :show, status: :ok, location: @offer }
            else
              @grid_disciplines = carregar_disciplinas_grade
              format.html { render :edit }
              format.json { render json: @offer.errors, status: :unprocessable_entity }
            end
          end
        end

      end
    rescue ActiveRecord::InvalidForeignKey
      respond_to do |format|
        @grid_disciplines = carregar_disciplinas_grade
        flash[:alert] = 'Não é possível alterar a grade ofertada. Já existem planos gerados.'
        format.html { render :edit }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
    # salvar_atualizar(false)
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
      format.html { redirect_to offers_url, notice: t('flash.actions.destroy.notice', resource_name: controller_name.classify.constantize.model_name.human) }
      format.json { head :no_content }
    end
  end

  def load_grid
    if !params[:grid_id].nil? && !params[:grid_id].blank?
      grid = Grid.find(params[:grid_id])
      params[:tipo_oferta] = grid.course.course_offer.description
      # binding.pry
      params[:minutos_aula] = grid.course.course_format.minutos_aula

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

  def pesquisar
    # @cursos_coordenador = Coordenador.where(user: current_user).pluck(:course_id) if !current_user.admin?
    # @cursos_coordenador = Offer.joins(:grid => :course).pluck('courses.id') if current_user.admin?

    # Se o usuário for um coordenador então mostra apenas os seus cursos
    if Coordenador.find_by(user: current_user).nil?
      @cursos_coordenador = Offer.joins(:grid => :course).pluck('courses.id')
    else
      @cursos_coordenador = Coordenador.where(user: current_user).pluck(:course_id)
    end
    if !@cursos_coordenador.empty?

      @ofertas = Offer.joins(:grid).where(:grids => { course_id: @cursos_coordenador})
      @turmas = @ofertas.order(turma: :desc).pluck(:turma).uniq
      @anos = @ofertas.order(year: :desc).pluck(:year).uniq
      @semestres = @ofertas.where.not(semestre: nil).order(semestre: :desc).pluck(:semestre).uniq
      # @semestres = [1,2]
      @cursos = Course.where(id: @cursos_coordenador)

      params[:curso] = @cursos.last.id if params[:curso].nil?
      params[:ano] = Date.today.year if params[:ano].nil?
      # params[:turma] = Date.today.year if params[:turma].nil?

      if !params[:curso].nil? && !params[:curso].blank?
        if !params[:ano].blank? && !params[:semestre].blank? && !params[:turma].blank?
          @resultado = Offer.joins(:grid).includes(:offer_disciplines => :plans).
          where('grids.course_id = ? AND offers.year = ? AND offers.semestre = ? and offers.turma = ?',
            params[:curso], params[:ano].to_i, params[:semestre].to_i, params[:turma].to_s
          ).order(semestre: :desc)
        elsif !params[:ano].blank? && params[:semestre].blank? && params[:turma].blank?
          @resultado = Offer.joins(:grid).includes(:offer_disciplines => :plans).
          where('grids.course_id = ? AND offers.year = ?',
            params[:curso], params[:ano].to_i
          ).order(semestre: :desc)
        elsif params[:ano].blank? && !params[:semestre].blank? && params[:turma].blank?
          @resultado = Offer.joins(:grid).includes(:offer_disciplines => :plans).
          where('grids.course_id = ? AND offers.semestre = ?',
            params[:curso], params[:semestre].to_i
          ).order(semestre: :desc)

        elsif !params[:ano].blank? && params[:semestre].blank? && !params[:turma].blank?
          @resultado = Offer.joins(:grid).includes(:offer_disciplines => :plans).
          where('grids.course_id = ? AND offers.year = ? AND offers.turma = ?',
            params[:curso], params[:ano].to_i, params[:turma].to_s
          ).order(semestre: :desc)

        elsif params[:ano].blank? && !params[:semestre].blank? && !params[:turma].blank?
          @resultado = Offer.joins(:grid).includes(:offer_disciplines => :plans).
          where('grids.course_id = ? AND offers.semestre = ? AND offers.turma = ?',
            params[:curso], params[:semestre].to_i, params[:turma].to_s
          ).order(semestre: :desc)

        elsif params[:ano].blank? && params[:semestre].blank? && !params[:turma].blank?
          @resultado = Offer.joins(:grid).includes(:offer_disciplines => :plans).
          where('grids.course_id = ? AND offers.turma = ?',
            params[:curso], params[:turma].to_s
          ).order(semestre: :desc)
        else
          @resultado = Offer.joins(:grid).includes(:offer_disciplines => :plans).
          where('grids.course_id = ?', params[:curso]
          ).order(semestre: :desc)
        end
      end
    end

    respond_to do |format|
      format.html { render 'offers/coordenador/index' }
      format.json
    end
  end

  # Avisar o professor da existência de planos pendentes
  def enviar_aviso_plano_pendente
    enviou = false
    if !params[:offer_id].nil?
      Offer.includes(:offer_disciplines => :plans).find(params[:offer_id]).offer_disciplines.each do |x|
        # Enviar aviso por e-mail para disciplinas sem plano ou com plano não aprovado ainda
        ultimo_plano = x.plans.order(versao: :desc).first
        if !x.user.nil? && (x.plans.empty? || (!x.plans.empty? && !ultimo_plano.user.nil? && !ultimo_plano.aprovado? && (!ultimo_plano.analise? || ultimo_plano.reprovado?)))
          PlanoEnsinoMailer.enviar_aviso_plano_pendente(current_user.email, x).deliver_later!
          enviou = true
        end
      end
    end
    if !params[:offer_discipline_id].nil?
      @offer_discipline = OfferDiscipline.find(params[:offer_discipline_id])
      PlanoEnsinoMailer.enviar_aviso_plano_pendente(current_user.email, @offer_discipline).deliver_later!
      enviou = true
    end

    respond_to do |format|
      # format.html { render 'offers/coordenador/index' }
      format.html { redirect_to ofertas_coordenador_path }
      format.json
      format.js {
        if enviou
          flash[:notice] = "Um aviso foi enviado ao professor."
        else
          flash[:warning] = "Nenhum plano de ensino pendente."
        end
      }
    end
  end

  def gerar_planos_lote
    if !@offer.nil?
      respond_to do |format|
        format.pdf {
          begin
            # coordenador = Coordenador.find_by(course_id: @offer.grid.course_id, responsavel:true)
            # if coordenador.nil?
            #   raise StandardError, "Coordenador não cadastrado para o curso #{@offer.grid.course.name}"
            # end

            # ZipNotifierJob.perform_later(@offer, current_user)

            planos = []
            @offer.offer_disciplines.each do |od|
              plano_oferta = ultimo_plano_por_disciplina(od.id)
              if !plano_oferta.nil?
                pdf = PlanPdf.new(plano_oferta, current_user).generate
                planos << [plano: plano_oferta, pdf: pdf]
              end
            end
            zip = ZipPdfGenerator.new(planos).comprimir

            if !zip.nil?
              send_data zip.ler, filename: 'PLANOS_DE_ENSINO.zip'
            end

          rescue StandardError => error
            message = "Ocorreu um erro interno. Favor entrar em contato com o suporte."
            logger.error error
            ExceptionNotifier.notify_exception(error)
            redirect_to ofertas_coordenador_path, alert: message
          end
        }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer
      @offer = Offer.find(params[:id])
    end

    def offer_params
      # params.permit(:year, :semestre, :type_offer, :grid_id, :turma, :active, :dtprevisao_entrega_plano,
      #   offer_disciplines_attributes: [:id, :grid_discipline_id, :user_id, :second_user_id, :active, :offer_id, :ead_percentual_maximo, :carga_horaria, :_destroy
      #   ]
      # )
      params.require(:offer).permit(:year, :semestre, :type_offer, :grid_id, :turma, :active, :dtprevisao_entrega_plano, :minutos_aula,
        offer_disciplines_attributes: [:id, :grid_discipline_id, :user_id, :second_user_id, :ead_percentual_maximo, :carga_horaria, :active, :offer_id, :_destroy
        ]
      )
    end
    # {turmas_id: []}, {offer_discipline_turmas_attributes: [:id, :offer_discipline_id, :turma_id]},

    def load_cursos
      @cursos = Course.where(active:true)
    end

    def load_professores
      @professores = User.distinct.joins(:perfils).where('users.teacher is true OR upper(perfils.name) = ?', 'PROFESSOR').order(:name)
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
      @grades = Grid.includes(:course).where(active:true).order('courses.name, grids.year')
      # @grades = Grid.includes(:course).
      #   joins(:grid_disciplines => :discipline).
      #   order('grid_disciplines.year', 'grid_disciplines.semestre').
      #   pluck('id', 'grid_disciplines.year', 'grid_disciplines.semestre', 'courses.name', 'year').uniq
    end

    def load_grade_anos(grid_id)
      if !grid_id.nil? && !grid_id.blank?
        Grid.joins(:grid_disciplines => :discipline).
          where('grids.id = ? and grid_disciplines.year is not null', grid_id).
          order('grid_disciplines.year').
          pluck('grid_disciplines.year').uniq
      end
    end

    def load_grade_semestres(grid_id)
      if !grid_id.nil? && !grid_id.blank?
        Grid.joins(:grid_disciplines => :discipline).
          where('grids.id = ? and grid_disciplines.semestre is not null', grid_id).
          order('grid_disciplines.semestre').
          pluck('grid_disciplines.semestre').uniq
      end
    end

    def load_formatos
      @formatos = CourseFormat.all
    end

end
