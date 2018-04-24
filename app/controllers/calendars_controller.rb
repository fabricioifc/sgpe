class CalendarsController < ApplicationController
  before_action :set_calendar, only: [:show, :edit, :update, :destroy]

  # GET /calendars
  # GET /calendars.json
  def index
    @calendars = Calendar.all
  end

  # GET /calendars/1
  # GET /calendars/1.json
  def show
  end

  # GET /calendars/new
  def new
    @calendar = Calendar.new
  end

  # GET /calendars/1/edit
  def edit
    @calendar.calendar_excludes
    @dts_exclusao = calendar_excludes_to_string
  end

  # POST /calendars
  # POST /calendars.json
  def create
    @calendar = Calendar.new(calendar_params)
    datas_exclusao = date_range_to_array calendar_params[:dts_exclusao]
    datas_exclusao.each do |data|
      @calendar.calendar_excludes << CalendarExclude.new(dt_exclusao: data)
    end

    respond_to do |format|
      if @calendar.save
        format.html { redirect_to @calendar, notice: 'Calendar was successfully created.' }
        format.json { render :show, status: :created, location: @calendar }
      else
        format.html { render :new }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calendars/1
  # PATCH/PUT /calendars/1.json
  def update
    datas_exclusao = date_range_to_array calendar_params[:dts_exclusao]
    @calendar.calendar_excludes = []
    datas_exclusao.each do |data|
      @calendar.calendar_excludes << CalendarExclude.new(dt_exclusao: data)
    end
    respond_to do |format|
      if @calendar.update(calendar_params)
        format.html { redirect_to @calendar, notice: 'Calendar was successfully updated.' }
        format.json { render :show, status: :ok, location: @calendar }
      else
        format.html { render :edit }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calendars/1
  # DELETE /calendars/1.json
  def destroy
    @calendar.destroy
    respond_to do |format|
      format.html { redirect_to calendars_url, notice: 'Calendar was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calendar
      @calendar = Calendar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def calendar_params
      params.require(:calendar).permit(:name, :offer_id, :dt_inicio, :dt_fim, :active, :dts_exclusao,
        calendar_excludes_attributes: [:id, :calendar_id, :dt_exclusao]
      )
    end

    # Converte as datas do datepicker de String para Date
    def date_range_to_array datas, separator=','
      result = []
      datas.split(separator).each do |data|
        result << data.to_date
      end
      result
    end

    # Converte as datas salvas em CalendarExclude de Date para String, separador por virgula
    def calendar_excludes_to_string separador=','
      result = ""
      @calendar.calendar_excludes.each_with_index do |data, index|
        result += (l data.dt_exclusao)
        result += separador if index != @calendar.calendar_excludes.size - 1
      end
      result
    end
end
