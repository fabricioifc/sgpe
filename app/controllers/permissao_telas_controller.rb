class PermissaoTelasController < ApplicationController
  before_action :set_permissao_tela, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /permissao_telas
  # GET /permissao_telas.json
  def index
    @permissao_telas = PermissaoTela.all
  end

  # GET /permissao_telas/1
  # GET /permissao_telas/1.json
  def show
  end

  # GET /permissao_telas/new
  def new
    @permissao_tela = PermissaoTela.new
  end

  # GET /permissao_telas/1/edit
  def edit
  end

  # POST /permissao_telas
  # POST /permissao_telas.json
  def create
    @permissao_tela = PermissaoTela.new(permissao_tela_params)

    respond_to do |format|
      if @permissao_tela.save
        format.html { redirect_to @permissao_tela, notice: 'Permissao tela was successfully created.' }
        format.json { render :show, status: :created, location: @permissao_tela }
      else
        format.html { render :new }
        format.json { render json: @permissao_tela.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /permissao_telas/1
  # PATCH/PUT /permissao_telas/1.json
  def update
    respond_to do |format|
      if @permissao_tela.update(permissao_tela_params)
        format.html { redirect_to @permissao_tela, notice: 'Permissao tela was successfully updated.' }
        format.json { render :show, status: :ok, location: @permissao_tela }
      else
        format.html { render :edit }
        format.json { render json: @permissao_tela.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /permissao_telas/1
  # DELETE /permissao_telas/1.json
  def destroy
    @permissao_tela.destroy
    respond_to do |format|
      format.html { redirect_to permissao_telas_url, notice: 'Permissao tela was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_permissao_tela
      @permissao_tela = PermissaoTela.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def permissao_tela_params
      params.require(:permissao_tela).permit(:permissao_id, :perfil_id)
    end
end
