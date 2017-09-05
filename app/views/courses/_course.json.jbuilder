json.extract! course, :id, :name, :sigla, :active, :carga_horaria, :CourseModality_id, :CourseFormat_id, :user_id, :created_at, :updated_at
json.url course_url(course, format: :json)
