json.extract! course, :id, :name, :sigla, :active, :course_modality_id, :course_format_id, :user_id, :created_at, :updated_at
json.url course_url(course, format: :json)
