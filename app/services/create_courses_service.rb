class CreateCoursesService

  def call
    formatos = []
    formatos << [ name: 'Integrado' ]
    formatos << [ name: 'Subsequente' ]
    formatos << [ name: 'Especialização' ]

    modalidades = []
    modalidades << [ sigla: 'PRE', description: 'Presencial']
    modalidades << [ sigla: 'SEM', description: 'Semi-presencial']
    modalidades << [ sigla: 'DIS', description: 'À Distância']

    formatos.each do |k, v|
      CourseFormat.find_or_create_by!(k)
    end

    modalidades.each do |k, v|
      CourseModality.find_or_create_by!(k)
    end

    cursos = []
    cursos << [
      name:             'Curso integrado ao ensino médio',
      sigla:            'INT',
      carga_horaria:    3000,
      course_modality:  CourseModality.find_by(sigla: 'PRE'),
      course_format:    CourseFormat.find_by(name: 'Integrado'),
      user:             User.where(admin: true).last,
    ]

    cursos.each do |k, v|
      Course.find_or_create_by!(k)
    end

    puts "Lista de cursos atualizada!"
  end
end
