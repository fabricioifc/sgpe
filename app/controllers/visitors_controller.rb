class VisitorsController < ApplicationController
  include ApplicationHelper

  def index

    if is_professor?
      # @ids = current_user.offer_disciplines.joins(:offer).select(:offer_id).where(active:true).where('offers.active = ?', true).group(:offer_id).map(&:offer_id)
      # @ofertasProfessor = Offer.where(id: @ids).order(year: :asc, semestre: :asc)

      @ofertasCursoProfessor = {}
      # @anos = current_user.offer_disciplines.joins(:offer).
      #   where(active:true).where('offers.active = ?', true).
      #   pluck('offers.year').uniq

      curso_ids = current_user.offer_disciplines.joins(:offer => :grid).
        where(active:true).where('offers.active = ?', true).
        pluck('grids.course_id').uniq

      @cursos = Course.where(id: curso_ids)

      curso_ids.each do |curso_id|
        @ofertasCursoProfessor[curso_id] = current_user.offer_disciplines.joins(:offer => :grid).
          joins(:grid_discipline => :discipline).
          where(active:true).where('offers.active = ?', true).
          where('grids.course_id = ?', curso_id).
          order('offers.year, offers.semestre, disciplines.title')

      end
    end


  end
end
