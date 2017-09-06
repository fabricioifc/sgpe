class CreateDisciplineService

  def call

    user = User.where(admin: true).last

    disciplinas = []
    disciplinas << [ title: 'Banco de Dados I', sigla: 'BDI', active: true, user: user ]
    disciplinas << [ title: 'Programação Web', sigla: 'PROW', active: true, user: user ]
    disciplinas << [ title: 'Engenharia de Software I', sigla: 'ENGI', active: true, user: user ]

    disciplinas.each do |k, v|
      Discipline.find_or_create_by!(k)
    end

    puts "Lista de disciplinas atualizada!"
  end
end
