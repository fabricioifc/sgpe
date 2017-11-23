module CoursesHelper

  def planos_por_curso curso_id
    if user_signed_in?
      @totais = Plan.joins(offer_discipline: {offer: { grid: :course }}).
        where('plans.active is true').
        where('courses.id = ?', curso_id).
        where('offer_disciplines.user_id = ?', current_user.id)

    end
  end

  # Retorna apenas os cursos onde o professor tenha algum plano de ensino ofertado
  def cursos_por_professor
    if user_signed_in? && is_professor?
      Plan.distinct.joins(offer_discipline: {offer: { grid: :course }}).
        where('plans.active is true').
        where('offer_disciplines.user_id = ?', current_user.id).pluck('courses.id, courses.name')
    end
  end

  def aprovados_por_curso planos
    planos.where(aprovado:true).count
  end

  def reprovados_por_curso planos
    planos.where(reprovado:true).count
  end

  def analise_por_curso planos
    planos.where(analise:true, aprovado:false, reprovado:false).count
  end

  def editando_por_curso planos
    planos.where(analise:false, aprovado:false, reprovado:false).count
  end

  def disciplinas_sem_plano_por_curso curso_id
    if user_signed_in? && !curso_id.nil?
      current_user.offer_disciplines.
        joins(offer: { grid: :course }).
        left_joins(:plans).
        where('offer_disciplines.active is true and courses.id = ? and plans.id is null', curso_id)
    end
  end

end
