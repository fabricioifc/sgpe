class PlansController < ApplicationController
  include ApplicationHelper
  include PlansHelper

  before_action :set_plan, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  before_action :load_professores
  before_action :pode_novo?, only: [:copy, :new, :create]
  before_action :pode_editar?, only: [:edit, :update]
  before_action :pode_excluir?, only: [:destroy]

  before_action :checar_professor_plano, except: [:show, :get_planos_aprovar, :aprovar]
  # before_action :checar_autorizacao_aprovar, only: [:get_planos_aprovar]

  def get_planos_aprovar
    if user_signed_in?
      @planos_aprovar = Plan.joins(offer_discipline: {offer: { grid: :course }}).
        where('plans.active is true').
        where(analise:true, aprovado:false, reprovado:false)

      render 'aprovacao'
    end
  end

  def aprovar
    aprovado = params[:commit_reprovar].nil?
    reprovado = !params[:commit_reprovar].nil?

    respond_to do |format|
      ActiveRecord::Base.transaction do
        if @plan.update(aprovado:aprovado, reprovado:reprovado)
          flash[:notice] = "Plano #{aprovado == true ? 'aprovado' : 'reprovado'} com sucesso."
          # format.html { render :show }
          format.html { redirect_to offer_offer_discipline_plan_path(@plan) }
          format.json { render :show, status: :updated, location: @plan }
        else
          format.html { render :show }
          format.json { render json: @plan.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def copy
    if is_professor?
      @source = Plan.find(params[:id])
      @plan = @source.dup
      @plan.versao = Plan.where(active:true, offer_discipline_id: params[:offer_discipline_id]).pluck(:versao).max
      params[:versao] = @plan.versao

      @curso = @plan.offer_discipline.grid_discipline.grid.course
      adicionar_breadcrumb_curso @curso
      render 'new'
    end
  end

  def course_plans
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
    @plan = Plan.new(offer_discipline_id: params[:offer_discipline_id])
    @plan.versao = Plan.where(active:true, offer_discipline_id: params[:offer_discipline_id]).pluck(:versao).max
    params[:versao] = @plan.versao

    @curso = @plan.offer_discipline.grid_discipline.grid.course
    adicionar_breadcrumb_curso @curso
    adicionar_breadcrumb_planos @plan
    @plan
  end

  # GET /plans/1/edit
  def edit
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
    if @plan.valid?
      @plan.versao = @plan.versao.nil? ? 1 : @plan.versao + 1
    end

    adicionar_breadcrumb_curso @plan.offer_discipline.grid_discipline.grid.course
    adicionar_breadcrumb_planos @plan

    respond_to do |format|
      ActiveRecord::Base.transaction do
        if params[:commit_analise]
          @plan.analise = true
        end
        if @plan.save
          format.html { redirect_to offer_offer_discipline_plans_path(@plan), notice: 'Plan was successfully created.' }
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
    adicionar_breadcrumb_curso @plan.offer_discipline.grid_discipline.grid.course
    adicionar_breadcrumb_planos @plan
    respond_to do |format|
      ActiveRecord::Base.transaction do
        if params[:commit_analise]
          @plan.update(:analise => true)
        end
        if @plan.update(plan_params)
          format.html { redirect_to offer_offer_discipline_plans_path(@plan), notice: 'Plan was successfully updated.' }
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
      format.html { redirect_to offer_offer_discipline_plans_path(offer_discipline_id: params[:offer_discipline_id]), notice: 'Plan was successfully destroyed.' }
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
      params.require(:plan).permit(:offer_discipline_id, :obj_espe, :conteudo_prog, :prat_prof, :interdisc, :met_tec, :met_met, :avaliacao, :cronograma, :atendimento, :versao, :active, :user_id, :analise, :aprovado, :reprovado)
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
      add_breadcrumb curso.sigla, plans_by_course_path(curso.id)
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

    def checar_autorizacao_aprovar
      authorize!(params[:action].to_sym, Plan)
    end

end
