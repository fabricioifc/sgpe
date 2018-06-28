module OffersHelper

  def disciplina_sem_plano offer_discipline_id
    if user_signed_in? && !offer_discipline_id.nil?
      lista1 = current_user.offer_disciplines.
        joins(offer: { grid: :course }).
        left_joins(:plans).
        where('offer_disciplines.active is true and offer_disciplines.id = ? and plans.id is null', offer_discipline_id)

      lista2 = current_user.offer_disciplines.
        joins(offer: { grid: :course }).
        left_joins(:plans).
        where('offer_disciplines.active is true and offer_disciplines.id = ? and plans.id is null', offer_discipline_id)
    
      # Unindo os dois resultados  
      lista1 | lista2
    end
  end

  def ofertas_sem_plano_por_professor
    if is_professor?
      lista1 = current_user.offer_disciplines.
        joins(offer: { grid: :course }).
        left_joins(:plans).
        where('offer_disciplines.active is true and plans.id is null')

      lista2 = current_user.offer_disciplines_second.
        joins(offer: { grid: :course }).
        left_joins(:plans).
        where('offer_disciplines.active is true and plans.id is null')

      # Unindo os dois resultados
      lista1 | lista2
    end
  end

end
