json.array! @ofertas do |offer|
  json.extract! offer, :id, :year, :semestre, :type_offer, :active, :turma, :created_at, :grid
  json.extract! offer.grid, :course
  json.url offer_url(offer)

  json.offer_disciplines offer.offer_disciplines do |od|
    if od.active?
      json.(od, :id, :user_id)
      if !od.user.nil?
        json.(od.user, :name, :email)
      end
      json.(od.grid_discipline, :discipline, :grid)
    end
  end
end
