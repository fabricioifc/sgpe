class VisitorsController < ApplicationController
  include ApplicationHelper

  def index
    # if is_professor?
    #
    #   curso_ids = current_user.offer_disciplines.joins(:offer => :grid).
    #     where(active:true).where('offers.active = ?', true).
    #     pluck('grids.course_id').uniq
    #
    #   @cursos = Course.where(id: curso_ids)
    # end

  end
end
