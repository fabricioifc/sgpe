class CoordenadorsController < ApplicationController
  before_action :set_coordenador, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  responders :flash

  # GET /coordenadors
  # GET /coordenadors.json
  def index
    # @coordenadors = Coordenador.all
    respond_to do |format|
      format.html
      format.json { render json: CoordenadorDatatable.new(view_context) }
    end
  end

  # GET /coordenadors/1
  # GET /coordenadors/1.json
  def show
  end

  # GET /coordenadors/new
  def new
    @coordenador = Coordenador.new
  end

  # GET /coordenadors/1/edit
  def edit
  end

  # POST /coordenadors
  # POST /coordenadors.json
  def create
    @coordenador = Coordenador.new(coordenador_params)

    respond_to do |format|
      if @coordenador.save
        verificar_titular
        verificar_responsavel
        format.html { redirect_to @coordenador, notice: t('flash.actions.create.notice', resource_name: controller_name.classify.constantize.model_name.human) }
        format.json { render :index, status: :created }
      else
        format.html { render :new }
        format.json { render json: @coordenador.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coordenadors/1
  # PATCH/PUT /coordenadors/1.json
  def update

    respond_to do |format|
      if @coordenador.update(coordenador_params)
        verificar_titular
        verificar_responsavel
        # format.html { redirect_to @coordenador, notice: 'Coordenador was successfully updated.' }
        format.html { redirect_to coordenadors_path, notice: t('flash.actions.update.notice', resource_name: controller_name.classify.constantize.model_name.human) }
        format.json { render :index, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @coordenador.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coordenadors/1
  # DELETE /coordenadors/1.json
  def destroy
    @coordenador.destroy
    respond_to do |format|
      # format.html { redirect_to coordenadors_url, notice: 'Coordenador was successfully destroyed.' }
      format.html { redirect_to coordenadors_url, notice: t('flash.actions.destroy.notice', resource_name: controller_name.classify.constantize.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coordenador
      @coordenador = Coordenador.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coordenador_params
      params.require(:coordenador).permit(:user_id, :email, :funcao, :titular, :responsavel, :course_id, :dtinicio, :dtfim)
    end

    def verificar_responsavel
      if @coordenador.responsavel?
        if @coordenador.id.nil?
          Coordenador.where(course_id: @coordenador.course_id).update(responsavel:false)
        else
          Coordenador.where(course_id: @coordenador.course_id).where.not(id: @coordenador.id).update(responsavel:false)
        end
      end
    end

    def verificar_titular
      if @coordenador.titular?
        if @coordenador.id.nil?
          Coordenador.where(course_id: @coordenador.course_id).update(titular:false)
        else
          Coordenador.where(course_id: @coordenador.course_id).where.not(id: @coordenador.id).update(titular:false)
        end
      end
    end
end
