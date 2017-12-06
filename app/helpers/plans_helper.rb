module PlansHelper

  def nenhum_plano_em_analise? offer_discipline_id
    Plan.where(offer_discipline_id: offer_discipline_id, active:true).
      where(analise:true).where(aprovado:false, reprovado:false).empty? unless offer_discipline_id.nil? || offer_discipline_id.blank?
  end

  def plano_sendo_editado? offer_discipline_id
    !Plan.where(offer_discipline_id: offer_discipline_id, active:true).
      where(analise:false).where(aprovado:false, reprovado:false).empty? unless offer_discipline_id.nil? || offer_discipline_id.blank?
  end

  def planos_por_disciplina offer_discipline_id
    Plan.joins(offer_discipline: {offer: { grid: :course }}).
      where('plans.active is true').
      where('offer_disciplines.id = ?', offer_discipline_id).
      where('offer_disciplines.user_id = ?', current_user.id) if user_signed_in? && !offer_discipline_id.nil?
  end

  def ultimo_plano_aprovado_por_disciplina offer_discipline_id
    Plan.joins(offer_discipline: {offer: { grid: :course }}).
      where('plans.active is true').
      where(aprovado:true).
      where('plans.user_id is not null').
      where('offer_disciplines.user_id is not null').
      where('offer_disciplines.id = ?', offer_discipline_id).
      order(versao: :desc).first if !offer_discipline_id.nil?
  end

  def aprovados_por_disciplina planos
    planos.where(aprovado:true).count
  end

  def reprovados_por_disciplina planos
    planos.where(reprovado:true).count
  end

  def analise_por_disciplina planos
    planos.where(analise:true, aprovado:false, reprovado:false).count
  end

  def editando_por_disciplina planos
    planos.where(analise:false, aprovado:false, reprovado:false).count
  end

  # Todos os planos aprovados
  def planos_aprovados professor = nil
    if user_signed_in?
      if professor.nil?
        Plan.where('plans.active is true').where(analise:true, aprovado:true, reprovado:false)
      else
        Plan.where('plans.active is true and plans.user_id = ?', professor.id).where(analise:true, aprovado:true, reprovado:false)
      end
    end
  end

  # Todos os planos reprovados
  def planos_reprovados professor = nil
    if user_signed_in?
      if professor.nil?
        Plan.where('plans.active is true').where(analise:true, aprovado:false, reprovado:true)
      else
        Plan.where('plans.active is true and plans.user_id = ?', professor.id).where(analise:true, aprovado:false, reprovado:true)
      end
    end
  end

  # Todos os planos em análise
  def planos_analisando professor = nil
    if user_signed_in?
      if professor.nil?
        Plan.where('plans.active is true').where(analise:true, aprovado:false, reprovado:false)
      else
        Plan.where('plans.active is true and plans.user_id = ?', professor.id).where(analise:true, aprovado:false, reprovado:false)
      end
    end
  end

  # Todos os planos sendo editado
  def planos_editando professor = nil
    if user_signed_in?
      if professor.nil?
        Plan.where('plans.active is true').where(analise:false, aprovado:false, reprovado:false)
      else
        Plan.where('plans.active is true and plans.user_id = ?', professor.id).where(analise:false, aprovado:false, reprovado:false)
      end
    end
  end

  # Todos os planos
  def planos_total professor = nil
    if user_signed_in?
      if professor.nil?
        Plan.where('plans.active is true')
      else
        Plan.where('plans.active is true and plans.user_id = ?', professor.id)
      end
    end
  end

end
