class PermissaosController < ApplicationController
  before_action :set_permissao, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /permissaos
  # GET /permissaos.json
  def index
    @permissaos = Permissao.all
  end

  # GET /permissaos/1
  # GET /permissaos/1.json
  def show
  end

  # GET /permissaos/new
  def new
    @permissao = Permissao.new
  end

  # GET /permissaos/1/edit
  def edit
  end

  # POST /permissaos
  # POST /permissaos.json
  def create
    @permissao = Permissao.new(permissao_params)

    respond_to do |format|
      if @permissao.save
        format.html { redirect_to @permissao, notice: 'Permissao was successfully created.' }
        format.json { render :show, status: :created, location: @permissao }
      else
        format.html { render :new }
        format.json { render json: @permissao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /permissaos/1
  # PATCH/PUT /permissaos/1.json
  def update
    respond_to do |format|
      if @permissao.update(permissao_params)
        format.html { redirect_to @permissao, notice: 'Permissao was successfully updated.' }
        format.json { render :show, status: :ok, location: @permissao }
      else
        format.html { render :edit }
        format.json { render json: @permissao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /permissaos/1
  # DELETE /permissaos/1.json
  def destroy
    @permissao.destroy
    respond_to do |format|
      format.html { redirect_to permissaos_url, notice: 'Permissao was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_permissao
      @permissao = Permissao.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def permissao_params
      params.require(:permissao).permit(:name, :classe, :acao, :idativo)
    end
end
