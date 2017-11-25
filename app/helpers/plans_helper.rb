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

end
