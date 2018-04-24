class CalendarExcludesController < ApplicationController
  before_action :set_calendar_exclude, only: [:show, :edit, :update, :destroy]

  # GET /calendar_excludes
  # GET /calendar_excludes.json
  def index
    @calendar_excludes = CalendarExclude.all
  end

  # GET /calendar_excludes/1
  # GET /calendar_excludes/1.json
  def show
  end

  # GET /calendar_excludes/new
  def new
    @calendar_exclude = CalendarExclude.new
  end

  # GET /calendar_excludes/1/edit
  def edit
  end

  # POST /calendar_excludes
  # POST /calendar_excludes.json
  def create
    @calendar_exclude = CalendarExclude.new(calendar_exclude_params)

    respond_to do |format|
      if @calendar_exclude.save
        format.html { redirect_to @calendar_exclude, notice: 'Calendar exclude was successfully created.' }
        format.json { render :show, status: :created, location: @calendar_exclude }
      else
        format.html { render :new }
        format.json { render json: @calendar_exclude.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calendar_excludes/1
  # PATCH/PUT /calendar_excludes/1.json
  def update
    respond_to do |format|
      if @calendar_exclude.update(calendar_exclude_params)
        format.html { redirect_to @calendar_exclude, notice: 'Calendar exclude was successfully updated.' }
        format.json { render :show, status: :ok, location: @calendar_exclude }
      else
        format.html { render :edit }
        format.json { render json: @calendar_exclude.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calendar_excludes/1
  # DELETE /calendar_excludes/1.json
  def destroy
    @calendar_exclude.destroy
    respond_to do |format|
      format.html { redirect_to calendar_excludes_url, notice: 'Calendar exclude was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calendar_exclude
      @calendar_exclude = CalendarExclude.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def calendar_exclude_params
      params.require(:calendar_exclude).permit(:calendar_id, :dt_exclusao)
    end
end
