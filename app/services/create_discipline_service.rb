class CreateDisciplineService

  def call

    user = User.where(admin: true).first

    if user.nil?
      puts "#{self.class.name}. Nenhum usuário administrador encontrado!"
    else

      disciplinas = []
      disciplinas << [ title: 'Artes I', sigla: 'ART', active: true, user: user ]
      disciplinas << [ title: 'Artes II', sigla: 'ART', active: true, user: user ]
      disciplinas << [ title: 'Artes III', sigla: 'ART', active: true, user: user ]
      disciplinas << [ title: 'Educação Física I', sigla: 'EDU', active: true, user: user ]
      disciplinas << [ title: 'Educação Física II', sigla: 'EDU', active: true, user: user ]
      disciplinas << [ title: 'Educação Física III', sigla: 'EDU', active: true, user: user ]
      disciplinas << [ title: 'Inglês I', sigla: 'ING', active: true, user: user ]
      disciplinas << [ title: 'Inglês II', sigla: 'ING', active: true, user: user ]
      disciplinas << [ title: 'Inglês III', sigla: 'ING', active: true, user: user ]
      disciplinas << [ title: 'Língua Portuguesa I', sigla: 'LÍN', active: true, user: user ]
      disciplinas << [ title: 'Língua Portuguesa II', sigla: 'LÍN', active: true, user: user ]
      disciplinas << [ title: 'Língua Portuguesa III', sigla: 'LÍN', active: true, user: user ]
      disciplinas << [ title: 'Filosofia I', sigla: 'FIL', active: true, user: user ]
      disciplinas << [ title: 'Filosofia II', sigla: 'FIL', active: true, user: user ]
      disciplinas << [ title: 'Filosofia III', sigla: 'FIL', active: true, user: user ]
      disciplinas << [ title: 'Geografia I', sigla: 'GEO', active: true, user: user ]
      disciplinas << [ title: 'Geografia II', sigla: 'GEO', active: true, user: user ]
      disciplinas << [ title: 'Geografia III', sigla: 'GEO', active: true, user: user ]
      disciplinas << [ title: 'História I', sigla: 'HIS', active: true, user: user ]
      disciplinas << [ title: 'História II', sigla: 'HIS', active: true, user: user ]
      disciplinas << [ title: 'História III', sigla: 'HIS', active: true, user: user ]
      disciplinas << [ title: 'Sociologia I', sigla: 'SOC', active: true, user: user ]
      disciplinas << [ title: 'Sociologia II', sigla: 'SOC', active: true, user: user ]
      disciplinas << [ title: 'Sociologia III', sigla: 'SOC', active: true, user: user ]
      disciplinas << [ title: 'Matemática I', sigla: 'MAT', active: true, user: user ]
      disciplinas << [ title: 'Matemática II', sigla: 'MAT', active: true, user: user ]
      disciplinas << [ title: 'Matemática III', sigla: 'MAT', active: true, user: user ]
      disciplinas << [ title: 'Biologia I', sigla: 'BIO', active: true, user: user ]
      disciplinas << [ title: 'Biologia II', sigla: 'BIO', active: true, user: user ]
      disciplinas << [ title: 'Biologia III', sigla: 'BIO', active: true, user: user ]
      disciplinas << [ title: 'Física I', sigla: 'FÍS', active: true, user: user ]
      disciplinas << [ title: 'Física II', sigla: 'FÍS', active: true, user: user ]
      disciplinas << [ title: 'Física III', sigla: 'FÍS', active: true, user: user ]
      disciplinas << [ title: 'Química I', sigla: 'QUÍ', active: true, user: user ]
      disciplinas << [ title: 'Química II', sigla: 'QUÍ', active: true, user: user ]
      disciplinas << [ title: 'Quimica III', sigla: 'QUI', active: true, user: user ]
      disciplinas << [ title: 'Espanhol I', sigla: 'ESP', active: true, user: user ]
      disciplinas << [ title: 'Espanhol II', sigla: 'ESP', active: true, user: user ]
      disciplinas << [ title: 'Espanhol III', sigla: 'ESP', active: true, user: user ]
      disciplinas << [ title: 'Projeto Integrador I', sigla: 'PRO', active: true, user: user ]
      disciplinas << [ title: 'Projeto Integrador III', sigla: 'PRO', active: true, user: user ]
      disciplinas << [ title: 'Algoritmos e Programação', sigla: 'ALG', active: true, user: user ]
      disciplinas << [ title: 'Desenvolvimento Front-End', sigla: 'DES', active: true, user: user ]
      disciplinas << [ title: 'Fundamentos de Informática', sigla: 'FUN', active: true, user: user ]
      disciplinas << [ title: 'Hardware e Sistemas Operacionais', sigla: 'HAR', active: true, user: user ]
      disciplinas << [ title: 'Redes de Computadores I', sigla: 'RED', active: true, user: user ]
      disciplinas << [ title: 'Banco de Dados', sigla: 'BAN', active: true, user: user ]
      disciplinas << [ title: 'Engenharia de Software ', sigla: 'ENG', active: true, user: user ]
      disciplinas << [ title: 'Programação Orientada a Objetos ', sigla: 'PRO', active: true, user: user ]
      disciplinas << [ title: 'Redes de Computadores II', sigla: 'RED', active: true, user: user ]
      disciplinas << [ title: 'Administração de Serviços de Rede', sigla: 'ADM', active: true, user: user ]
      disciplinas << [ title: 'Administração e Empreendedorismo', sigla: 'ADM', active: true, user: user ]
      disciplinas << [ title: 'Programação Web', sigla: 'PRO', active: true, user: user ]
      disciplinas << [ title: 'Tópicos Especiais ', sigla: 'TÓP', active: true, user: user ]

      disciplinas.each do |k, v|
        Discipline.find_or_create_by(k)
      end

      puts "Lista de disciplinas atualizada!"
    end
  end
end
