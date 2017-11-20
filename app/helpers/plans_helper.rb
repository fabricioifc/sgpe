module PlansHelper

  def nenhum_plano_em_analise? offer_discipline_id
    Plan.where(offer_discipline_id: offer_discipline_id, active:true).
      where(analise:true).where(aprovado:false, reprovado:false).empty? unless offer_discipline_id.nil? || offer_discipline_id.blank?
  end

  def plano_sendo_editado? offer_discipline_id
    !Plan.where(offer_discipline_id: offer_discipline_id, active:true).
      where(analise:false).where(aprovado:false, reprovado:false).empty? unless offer_discipline_id.nil? || offer_discipline_id.blank?
  end

end
