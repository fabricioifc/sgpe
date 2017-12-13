class PlansController < ApplicationController
  include ApplicationHelper
  include PlansHelper
  responders :flash

  before_action :set_plan, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  before_action :load_professores
  before_action :pode_novo?, only: [:copy, :new, :create]
  before_action :pode_editar?, only: [:edit, :update]
  before_action :pode_excluir?, only: [:destroy]

  before_action :checar_professor_plano, except: [:show, :get_planos_aprovar, :aprovar]
  # before_action :get_planos_aprovar_search, only: [:get_planos_aprovar]
  before_action :set_public_index

  def public_index
    # Cursos com algum plano aprovado
    @cursos = Course.joins(grids: {grid_disciplines: {offer_disciplines: :plans}}).where('plans.active is true').where('plans.aprovado is true')

    respond_to do |format|
      format.html { render 'plans/public/index' }
      format.json
    end
  end

  def public_index_course
    unless params[:course_id].nil?

      respond_to do |format|
        format.html { redirect_to public_disciplinas_path(params[:course_id]) }
      end
    end
  end

  def public_disciplinas
    unless params[:course_id].nil?
      @discipline = Discipline.new
      # Disciplinas por curso com plano aprovado
      @disciplinas = Discipline.joins(grid_disciplines: { offer_disciplines: :plans}).
        joins(grid_disciplines: {grid: :course}).
        where('plans.aprovado is true').
        where('plans.active is true').
        where('courses.id = ?', params[:course_id])
      respond_to do |format|
        format.html { render 'plans/public/disciplinas' }
        format.json
      end

    end
  end

  def public_disciplina_planos
    unless params[:discipline_id].nil? && params[:course_id].nil?
      respond_to do |format|
        format.html { redirect_to public_curso_disciplina_planos_path(params[:course_id], params[:discipline_id]) }
      end

    end
  end

  def public_curso_disciplina_planos
    unless params[:discipline_id].nil? && params[:course_id].nil?
      @discipline = Discipline.find(params[:discipline_id])
      @course = Course.find(params[:course_id])
      # Disciplinas por curso com plano aprovado
      @planos = Plan.joins(offer_discipline: { grid_discipline: :discipline}).
        joins(offer_discipline: { grid_discipline: {grid: :course} }).
        where('plans.aprovado is true').
        where('plans.active is true').
        where('disciplines.id = ?', params[:discipline_id]).
        where('courses.id = ?', params[:course_id])
      respond_to do |format|
        format.html { render 'plans/public/planos' }
        format.json
      end

    end
  end

  def publico_index
    # Cursos com algum plano aprovado
    @cursos = Course.joins(grids: {grid_disciplines: {offer_disciplines: :plans}}).where('plans.active is true').where('plans.aprovado is true')

    respond_to do |format|
      format.html { render 'plans/publico/index' }
      format.json
    end
  end

  def publico_index_planos
    if !params[:course_id].nil? && !params[:course_id].blank?
      @course = Course.find(params[:course_id])
      # Disciplinas por curso com plano aprovado
      @planos = Plan.joins(offer_discipline: { grid_discipline: :discipline}).
        joins(offer_discipline: { grid_discipline: {grid: :course} }).
        where('plans.aprovado is true').
        where('plans.active is true').
        where('courses.id = ?', params[:course_id])
    end

    @cursos = Course.joins(grids: {grid_disciplines: {offer_disciplines: :plans}}).where('plans.active is true').where('plans.aprovado is true')

    respond_to do |format|
      format.html { render 'plans/publico/planos' }
      # format.html { redirect_to publico_index_planos_path }
      format.json
    end
  end

  def get_planos_aprovar
    if user_signed_in?
      # @planos_aprovar = Plan.joins(offer_discipline: {offer: { grid: :course }}).
      #   where('plans.active is true').
      #   where(analise:true, aprovado:false, reprovado:false)
      respond_to do |format|
        format.html { render 'aprovacao' }
        format.json { render json: AprovarPlanosDatatable.new(view_context, current_user) }
      end
    end
  end

  # aprovar ou reprovar o plano de ensino
  def aprovar
    aprovado = params[:commit_reprovar].nil?
    reprovado = !params[:commit_reprovar].nil?

    respond_to do |format|
      # Se alguém já aprovou o plano então somente ele poderá analisar novamente
      if @plan.user_parecer.nil? || @plan.user_parecer.eql?(current_user)
        ActiveRecord::Base.transaction do
          if @plan.update(aprovado:aprovado, reprovado:reprovado, parecer: plan_params[:parecer], user_parecer: current_user)
            flash[:notice] = "Plano #{aprovado == true ? 'aprovado' : 'com pendências'}."
            # format.html { redirect_to aprovar_offer_offer_discipline_plan_path(@plan) }
            format.html { redirect_to get_planos_aprovar_path }
            # format.json { render :show, status: :updated, location: @plan }
          else
            format.html { render :show }
            format.json { render json: @plan.errors, status: :unprocessable_entity }
          end
        end
      else
        flash[:warning] = "Não foi possível efetuar a operação. Este plano já foi analisado por outro usuário."
        format.html { render :show }
      end
    end
  end

  def copy
    if is_professor?
      @source = Plan.find(params[:id])
      @plan = @source.dup
      # @plan.versao = Plan.where(active:true, offer_discipline_id: params[:offer_discipline_id]).pluck(:versao).max
      # params[:versao] = @plan.versao

      @curso = @plan.offer_discipline.grid_discipline.grid.course
      adicionar_breadcrumb_curso @curso
      render 'new'
    end
  end

  def planos_curso
    if is_professor?
      # Pode ser que o parâmetro venha de um form de pesquisa (course_tag_id)
      params[:course_id] = params[:course_id_tag] || params[:course_id]
      params[:discipline_id] = params[:discipline_id_tag] || params[:discipline_id]
      params[:ano] = params[:ano_tag]

      @curso = Course.find(params[:course_id])
      @ofertasCursoProfessor = current_user.offer_disciplines.joins(:offer => :grid).
        joins(:grid_discipline => :discipline).
        where(active:true).where('offers.active = ?', true).
        where('grids.course_id = ?', params[:course_id]).
        where(params[:discipline_id].blank? ? 'disciplines.id is not null' : 'disciplines.id = ?', params[:discipline_id]).
        where(params[:ano].blank? ? 'offers.year is not null' : 'offers.year = ?', params[:ano]).
        order('offers.year desc, offers.semestre desc, disciplines.title').
        group_by{ |c| [c.offer.year, c.offer.semestre] }

      adicionar_breadcrumb_curso @curso
    end
  end

  def planos_professor
    if is_professor?

      curso_ids = current_user.offer_disciplines.joins(:offer => :grid).
        where(active:true).where('offers.active = ?', true).
        pluck('grids.course_id').uniq

      @cursos = Course.where(id: curso_ids)
    end
  end

  # GET /plans
  # GET /plans.json
  def index
    if !params[:offer_discipline_id].nil?
      # @disciplina = Discipline.joins(:grid_disciplines => :offer_disciplines).find_by('offer_disciplines.id = ?', params[:offer_discipline_id])
      @offer_discipline = OfferDiscipline.find(params[:offer_discipline_id])
      @plans = get_planos_disciplina params[:offer_discipline_id]

      @curso = @offer_discipline.grid_discipline.grid.course
      adicionar_breadcrumb_curso @curso
    end
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
    respond_to do |format|
      format.html {
        @curso = @plan.offer_discipline.grid_discipline.grid.course
        adicionar_breadcrumb_curso @curso
        adicionar_breadcrumb_planos @plan
      }
      format.json
      format.pdf {
          pdf = PlanPdf.new(@plan, current_user).generate
          send_data pdf.render,
            filename: "#{@plan.created_at.strftime("%Y%m%d")}_plano#{@plan.id}.pdf",
            type: "application/pdf",
            disposition: :inline
      }
    end
  end

  # GET /plans/new
  def new
    # @plan = Plan.new(offer_discipline_id: params[:offer_discipline_id])
    @plan = Plan.new(offer_discipline_id: params[:offer_discipline_id])
    # @plan.versao = Plan.where(active:true, offer_discipline_id: params[:offer_discipline_id]).pluck(:versao).max
    # params[:versao] = @plan.versao

    @curso = @plan.offer_discipline.grid_discipline.grid.course
    adicionar_breadcrumb_curso @curso
    adicionar_breadcrumb_planos @plan
    @plan
  end

  # GET /plans/1/edit
  def edit
    params[:ementa] = @plan.offer_discipline.grid_discipline.ementa
    params[:objetivo_geral] = @plan.offer_discipline.grid_discipline.objetivo_geral
    params[:bib_geral] = @plan.offer_discipline.grid_discipline.bib_geral
    params[:bib_espec] = @plan.offer_discipline.grid_discipline.bib_espec
    adicionar_breadcrumb_curso @plan.offer_discipline.grid_discipline.grid.course
    adicionar_breadcrumb_planos @plan
  end

  # POST /plans
  # POST /plans.json
  def create
    @plan = Plan.new(plan_params)
    @plan.offer_discipline_id = params[:offer_discipline_id]
    @plan.user = current_user
    @plan.active = true
    ultima_versao = Plan.where(active:true, offer_discipline_id: params[:offer_discipline_id]).pluck(:versao).max
    @plan.versao = ultima_versao.nil? ? 1 : ultima_versao + 1

    if @plan.offer_discipline.grid_discipline.discipline.especial?
      @plan.offer_discipline.grid_discipline.ementa = params[:ementa]
      @plan.offer_discipline.grid_discipline.objetivo_geral = params[:objetivo_geral]
      @plan.offer_discipline.grid_discipline.bib_geral = params[:bib_geral]
      @plan.offer_discipline.grid_discipline.bib_espec = params[:bib_espec]
    end

    adicionar_breadcrumb_curso @plan.offer_discipline.grid_discipline.grid.course
    adicionar_breadcrumb_planos @plan

    respond_to do |format|
      ActiveRecord::Base.transaction do
        if params[:commit_analise]
          @plan.analise = true
        end
        if @plan.save
          format.html { redirect_to offer_offer_discipline_plans_path(@plan), notice: t('flash.actions.create.notice', resource_name: controller_name.classify.constantize.model_name.human) }
          format.json { render :show, status: :created, location: @plan }
        else
          format.html { render :new }
          format.json { render json: @plan.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /plans/1
  # PATCH/PUT /plans/1.json
  def update
    if @plan.offer_discipline.grid_discipline.discipline.especial?
      @plan.offer_discipline.grid_discipline.ementa = params[:ementa]
      @plan.offer_discipline.grid_discipline.objetivo_geral = params[:objetivo_geral]
      @plan.offer_discipline.grid_discipline.bib_geral = params[:bib_geral]
      @plan.offer_discipline.grid_discipline.bib_espec = params[:bib_espec]
    end

    adicionar_breadcrumb_curso @plan.offer_discipline.grid_discipline.grid.course
    adicionar_breadcrumb_planos @plan
    respond_to do |format|
      ActiveRecord::Base.transaction do
        if params[:commit_analise]
          @plan.update(:analise => true)
        end
        if @plan.update(plan_params)
          format.html { redirect_to offer_offer_discipline_plans_path(@plan), notice: t('flash.actions.update.notice', resource_name: controller_name.classify.constantize.model_name.human) }
          format.json { render :show, status: :ok, location: @plan }
        else
          format.html { render :edit }
          format.json { render json: @plan.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to offer_offer_discipline_plans_path(offer_discipline_id: params[:offer_discipline_id]), notice: t('flash.actions.destroy.notice', resource_name: controller_name.classify.constantize.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
      params.require(:plan).permit(:offer_discipline_id, :obj_espe, :conteudo_prog, :prat_prof, :interdisc, :met_tec, :met_met, :avaliacao, :cronograma, :atendimento, :versao, :active, :user_id, :analise, :aprovado, :reprovado, :parecer, :user_parecer_id,
        offer_discipline_attributes: [grid_discipline_attributes: [:ementa, :objetivo_geral, :bib_geral, :bib_espec]]
      )
    end

    def load_professores
      @professores = User.where(teacher:true).order(:name)
    end

    def pode_novo?
      mensagem = nil
      if plano_sendo_editado?(params[:offer_discipline_id])
        mensagem = 'Já existe um plano sendo editado.'
      elsif !nenhum_plano_em_analise?(params[:offer_discipline_id])
        mensagem = 'Existem planos sendo analisados. Aguarde aprovação/reprovação.'
      end
      if !mensagem.nil?
        respond_to do |format|
          format.html { redirect_to offer_offer_discipline_plans_path(offer_discipline_id: params[:offer_discipline_id]),
            alert: mensagem }
        end
      end
    end

    def pode_editar?
      if (@plan.aprovado? || @plan.reprovado? || !nenhum_plano_em_analise?(params[:offer_discipline_id]))
        respond_to do |format|
          format.html { redirect_to offer_offer_discipline_plans_path(offer_discipline_id: params[:offer_discipline_id]),
            alert: 'Existem planos sendo analisados. Aguarde aprovação/reprovação.' }
        end
      end
    end

    def pode_excluir?
      !@plan.analise? && !@plan.aprovado? && !@plan.reprovado?
    end

    def adicionar_breadcrumb_curso curso
      add_breadcrumb curso.sigla, planos_curso_path(curso.id)
    end

    def adicionar_breadcrumb_planos plano
      add_breadcrumb 'Meus planos', offer_offer_discipline_plans_path(offer_discipline_id: plano.offer_discipline_id)
    end

    def checar_professor_plano
      if !params[:offer_discipline_id].nil?
        @offer_discipline = OfferDiscipline.find(params[:offer_discipline_id])
        raise CanCan::AccessDenied if @offer_discipline.user != current_user
      end
    end

    # def get_planos_aprovar_search
    #   @plan_search = PlanSearch.new(analise:true) if params[:plan_search].nil?
    # end

    def set_public_index
      @curso = Course.last
    end

end
