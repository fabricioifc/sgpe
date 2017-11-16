class VisitorsController < ApplicationController
  include ApplicationHelper

  def index
    if is_professor?
      # @ids = current_user.offer_disciplines.joins(:offer).select(:offer_id).where(active:true).where('offers.active = ?', true).group(:offer_id).map(&:offer_id)
      # @ofertasProfessor = Offer.where(id: @ids).order(year: :asc, semestre: :asc)

      @ofertasProfessor = current_user.offer_disciplines.joins(:offer).joins(:grid_discipline => :discipline).
        where(active:true).where('offers.active = ?', true).
        order('offers.year, offers.semestre, disciplines.title')
    end
  end
end
