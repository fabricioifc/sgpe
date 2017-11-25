class CreateDisciplineService

  def call

    user = User.where(admin: true).last

    disciplinas = []
    disciplinas << [ title: 'Banco de Dados I', sigla: 'BDI', active: true, user: user ]
    disciplinas << [ title: 'Programação Web', sigla: 'PROW', active: true, user: user ]
    disciplinas << [ title: 'Engenharia de Software I', sigla: 'ENGI', active: true, user: user ]
    disciplinas << [ title: 'Matemática', sigla: 'MAT', active: true, user: user ]
    disciplinas << [ title: 'Língua Portuguesa', sigla: 'POR', active: true, user: user ]
    disciplinas << [ title: 'Inglês', sigla: 'ING', active: true, user: user ]
    disciplinas << [ title: 'Física', sigla: 'FIS', active: true, user: user ]
    disciplinas << [ title: 'Química', sigla: 'QUI', active: true, user: user ]
    disciplinas << [ title: 'Biologia', sigla: 'BIO', active: true, user: user ]
    disciplinas << [ title: 'Espanhol', sigla: 'ESP', active: true, user: user ]
    disciplinas << [ title: 'História', sigla: 'HIS', active: true, user: user ]
    disciplinas << [ title: 'Filosofia', sigla: 'FIL', active: true, user: user ]
    disciplinas << [ title: 'Sociologia', sigla: 'SOC', active: true, user: user ]
    disciplinas << [ title: 'Geografia', sigla: 'GEO', active: true, user: user ]
    disciplinas << [ title: 'Educação Física', sigla: 'EDU', active: true, user: user ]
    disciplinas << [ title: 'Lógica de Programação', sigla: 'LOG', active: true, user: user ]
    disciplinas << [ title: 'Fundamentos de Informática', sigla: 'FUN', active: true, user: user ]
    disciplinas << [ title: 'Multimídia', sigla: 'MUL', active: true, user: user ]
    disciplinas << [ title: 'Introdução a Informática', sigla: 'INT', active: true, user: user ]
    disciplinas << [ title: 'Desenvolvimento Web', sigla: 'DES', active: true, user: user ]
    disciplinas << [ title: 'Projeto Integrador', sigla: 'PIN', active: true, user: user ]

    disciplinas.each do |k, v|
      Discipline.find_or_create_by(k)
    end

    puts "Lista de disciplinas atualizada!"
  end
end
