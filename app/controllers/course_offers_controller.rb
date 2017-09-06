class CourseOffersController < ApplicationController
  before_action :set_course_offer, only: [:show, :edit, :update, :destroy]

  # GET /course_offers
  # GET /course_offers.json
  def index
    # @course_offers = CourseOffer.all
    respond_to do |format|
      format.html
      format.json { render json: CourseOfferDatatable.new(view_context) }
    end
  end

  # GET /course_offers/1
  # GET /course_offers/1.json
  def show
  end

  # GET /course_offers/new
  def new
    @course_offer = CourseOffer.new
  end

  # GET /course_offers/1/edit
  def edit
  end

  # POST /course_offers
  # POST /course_offers.json
  def create
    @course_offer = CourseOffer.new(course_offer_params)

    respond_to do |format|
      if @course_offer.save
        format.html { redirect_to @course_offer, notice: 'Course offer was successfully created.' }
        format.json { render :show, status: :created, location: @course_offer }
      else
        format.html { render :new }
        format.json { render json: @course_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_offers/1
  # PATCH/PUT /course_offers/1.json
  def update
    respond_to do |format|
      if @course_offer.update(course_offer_params)
        format.html { redirect_to @course_offer, notice: 'Course offer was successfully updated.' }
        format.json { render :show, status: :ok, location: @course_offer }
      else
        format.html { render :edit }
        format.json { render json: @course_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_offers/1
  # DELETE /course_offers/1.json
  def destroy
    @course_offer.destroy
    respond_to do |format|
      format.html { redirect_to course_offers_url, notice: 'Course offer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_offer
      @course_offer = CourseOffer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_offer_params
      params.require(:course_offer).permit(:description, :active)
    end
end
