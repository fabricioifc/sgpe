class CreateCourseService

  def call
    formatos = []
    formatos << [ name: 'Integrado', minutos_aula: 45 ]
    formatos << [ name: 'Subsequente', minutos_aula: 50 ]
    formatos << [ name: 'Especialização', minutos_aula: 50 ]

    modalidades = []
    modalidades << [ sigla: 'PRE', description: 'Presencial']
    modalidades << [ sigla: 'SEM', description: 'Semi-presencial']
    modalidades << [ sigla: 'DIS', description: 'À Distância']

    ofertas = []
    ofertas << [description: 'anual']
    ofertas << [description: 'semestral']
    ofertas << [description: 'ciclo']
    ofertas << [description: 'oferta_unica']

    formatos.each do |k, v|
      CourseFormat.find_or_create_by!(k)
    end

    modalidades.each do |k, v|
      CourseModality.find_or_create_by!(k)
    end

    ofertas.each do |k, v|
      CourseOffer.find_or_create_by!(k)
    end

    cursos = []
    cursos << [
      name:             'Curso integrado ao ensino médio',
      sigla:            'INT',
      carga_horaria:    1200,
      course_modality:  CourseModality.find_by(sigla: 'PRE'),
      course_format:    CourseFormat.find_by(name: 'Integrado'),
      course_offer:     CourseOffer.find_by(description: 'anual'),
      user:             User.where(admin: true).last,
    ]

    cursos.each do |k, v|
      Course.find_or_create_by(k)
    end

    puts "Lista de cursos atualizada!"
  end
end
