module OffersHelper

  def disciplina_sem_plano offer_discipline_id
    if user_signed_in? && !offer_discipline_id.nil?
      current_user.offer_disciplines.
        joins(offer: { grid: :course }).
        left_joins(:plans).
        where('offer_disciplines.active is true and offer_disciplines.id = ? and plans.id is null', offer_discipline_id)
    end
  end

end
