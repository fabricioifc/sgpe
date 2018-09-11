json.extract! offer, :id, :year, :semestre, :type_offer, :active, :turma, :dtprevisao_entrega_plano, :created_at, :updated_at
json.extract! offer.grid, :course
json.url offer_url(offer, format: :json)

json.offer_disciplines offer.offer_disciplines do |od|
  json.(od, :id, :user_id, :active, :grid_discipline)
  if !od.user.nil?
    json.(od.user, :name, :email)
  end
  json.(od.grid_discipline, :discipline, :grid)
end