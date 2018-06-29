module OffersHelper

  def disciplina_sem_plano offer_discipline_id
    if user_signed_in? && !offer_discipline_id.nil?
      OfferDiscipline.joins(offer: { grid: :course }).
        left_joins(:plans).
        where('offer_disciplines.active is true and offer_disciplines.id = ? and plans.id is null', offer_discipline_id).
        where('(offer_disciplines.user_id = ? OR offer_disciplines.second_user_id = ?)', current_user.id, current_user.id)
    end
  end

  def ofertas_sem_plano_por_professor
    if is_professor?
      OfferDiscipline.joins(offer: { grid: :course }).
        left_joins(:plans).
        where('offer_disciplines.active is true and plans.id is null').
        where('(offer_disciplines.user_id = ? OR offer_disciplines.second_user_id = ?)', current_user.id, current_user.id)
    end
  end

end
