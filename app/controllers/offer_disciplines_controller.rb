class OfferDisciplinesController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  load_and_authorize_resource


private

  def offer_discipline_params
    params.require(:offer_discipline).permit(:id, :grid_discipline_id, :user_id, :active, :offer_id)
  end

end
