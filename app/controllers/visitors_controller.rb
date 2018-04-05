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

    @class_panel1 = 'col-md-12'
    @class_panel2 = ''

    @class_panel1 = 'col-md-8' if (is_professor?) || (can? :aprovar_reprovar, Plan)
    @class_panel2 = 'col-md-4' if (is_professor?) || (can? :aprovar_reprovar, Plan)

  end
end
