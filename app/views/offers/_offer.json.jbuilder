json.extract! offer, :id, :year, :semestre, :type_offer, :active, :turma, :dtprevisao_entrega_plano, :created_at, :updated_at
json.url offer_url(offer, format: :json)

json.offer_disciplines offer.offer_disciplines do |od|
  json.(od, :id, :user_id, :active, :grid_discipline)
  if !od.user.nil?
    json.(od.user, :name, :email)
  end
  json.(od.grid_discipline, :discipline, :grid)
  json.(od.grid_discipline.grid, :course)
  json.(od.grid_discipline.grid.course, :course_modality, :course_format, :course_offer )
end