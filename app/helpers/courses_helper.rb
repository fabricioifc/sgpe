module CoursesHelper

  def ultimo_status_planos_curso curso_id, analise = nil, aprovado = nil, reprovado = nil
    lista = []

    ultimos_planos = Plan.select('offer_discipline_id, MAX(versao) AS versao').
      joins(offer_discipline: {offer: { grid: :course }}).
      group(:offer_discipline_id).
      where('plans.active is true').
      where('courses.id = ?', curso_id).
      where('offer_disciplines.user_id = ?', current_user.id)

    ultimos_planos.each do |plano|
      plano = Plan.find_by(offer_discipline_id: plano.offer_discipline_id, versao: plano.versao)
      if analise.nil? && aprovado.nil? && reprovado.nil?
        lista << plano
      else
        lista << plano if plano.analise.eql?(analise) && plano.aprovado.eql?(aprovado) && plano.reprovado.eql?(reprovado)
      end
    end
    lista
  end

  def planos_por_curso curso_id
    if user_signed_in?
      # @totais = Plan.joins(offer_discipline: {offer: { grid: :course }}).
      #   where('plans.active is true').
      #   where('courses.id = ?', curso_id).
      #   where('offer_disciplines.user_id = ?', current_user.id)
      ultimo_status_planos_curso(curso_id)
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

  def aprovados_por_curso curso_id
    # planos.where(aprovado:true).count
    ultimo_status_planos_curso(curso_id, true, true, false).count
  end

  def reprovados_por_curso curso_id
    # planos.where(reprovado:true).count
    ultimo_status_planos_curso(curso_id, true, false, true).count
  end

  def analise_por_curso curso_id
    # planos.where(analise:true, aprovado:false, reprovado:false).count
    ultimo_status_planos_curso(curso_id, true, false, false).count
  end

  def editando_por_curso curso_id
    # planos.where(analise:false, aprovado:false, reprovado:false).count
    ultimo_status_planos_curso(curso_id, false, false, false).count
  end

  def disciplinas_sem_plano_por_curso curso_id
    if user_signed_in? && !curso_id.nil?
      OfferDiscipline.joins(offer: { grid: :course }).
        left_joins(:plans).
        where('offer_disciplines.active is true and courses.id = ? and plans.id is null', curso_id).
        where('(offer_disciplines.user_id = ? OR offer_disciplines.second_user_id = ?)', current_user.id, current_user.id)
    end
  end

  def get_ultimo_plano_disciplina offer_discipline_id
    Plan.joins(:offer_discipline).where(active:true).where(offer_discipline_id: offer_discipline_id).order(versao: :desc).first
  end

end
