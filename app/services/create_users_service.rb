class CreateUsersService

  def call
    senha_padrao = 'ifcfraiburgo'

    # Usuários NUPE, CGE, DDE com seus devidos perfis
    users = []
    users << User.new( name: 'Sandra de Fátima Lucietti', email: 'sandra.lucietti@fraiburgo.ifc.edu.br', perfils: [Perfil.find_by(name: 'NUPE')] )
    users << User.new( name: 'Débora de Lima Velho Junges', email: 'debora.junges@ifc.edu.br', perfils: [Perfil.find_by(name: 'NUPE')] )
    users << User.new( name: 'Pedro dos Santos Faccin', email: 'pedro.faccin@ifc.edu.br', perfils: [Perfil.find_by(name: 'NUPE')] )
    users << User.new( name: 'Coordenação Geral de Ensino', email: 'cge@fraiburgo.ifc.edu.br', perfils: [Perfil.find_by(name: 'DDE'), Perfil.find_by(name: 'CGE')] )
    users << User.new( name: 'Tiago Gonçalves', email: 'tiago.goncalves@ifc.edu.br', admin:true, teacher:true, perfils: [Perfil.find_by(name: 'DDE')] )
    users << User.new( name: 'Paulo Roberto Ribeiro Nunes', email: 'paulo.nunes@fraiburgo.ifc.edu.br', perfils: [Perfil.find_by(name: 'NUPE')])

    users.each do |u, v|
      if User.find_by(email: u.email).nil?
        # u.username               = u.email.split('@')[0]
        u.username               = u.name.parameterize.underscore
        u.password               = senha_padrao
        u.password_confirmation  = senha_padrao
        u.perfils                = u.perfils
        u.confirm
        u.save!
      end
    end

    # users.each do |u, v|
    #   u[:username] = u[:email].split('@')[0]
    #   user = User.find_or_create_by(email: u[:email]) do |user|
    #     user ||= u
    #     user.password               = u[:username]
    #     user.password_confirmation  = u[:username]
    #     user.perfils = u[:perfils]
    #     user.confirm
    #   end
    # end

    # if Rails.env.development?
    #   10.times do
    #
    #     user = User.find_or_create_by(email: Faker::Internet.email) do |user|
    #       user.username               = user.email.split('@')[0]
    #       user.name                   = Faker::Name.name
    #       user.password               = '123456'
    #       user.password_confirmation  = '123456'
    #       user.admin                  = false
    #       user.teacher                = true
    #       user.confirm
    #     end
    #   end
    # end
  end
end
