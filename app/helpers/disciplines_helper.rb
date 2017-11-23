module DisciplinesHelper
  # Retorna apenas os cursos onde o professor tenha algum plano de ensino ofertado
  def disciplinas_curso_e_por_professor
    if user_signed_in? && is_professor?
      OfferDiscipline.distinct.joins(grid_discipline: {grid: :course }).
        joins(grid_discipline: :discipline).
        where('offer_disciplines.active is true').
        where('courses.id = ?', params[:course_id]).
        where('offer_disciplines.user_id = ?', current_user.id).pluck('disciplines.id, disciplines.title')
    end
  end
end
