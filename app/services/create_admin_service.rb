class CreateAdminService
  def call
    # Administrador do sistema
    user = User.find_or_create_by(email: Rails.application.secrets.admin_email) do |user|
      user.username                   = Rails.application.secrets.admin_username
      user.name                   = Rails.application.secrets.admin_name
      user.password               = Rails.application.secrets.admin_password
      user.password_confirmation  = Rails.application.secrets.admin_password
      user.admin                  = true
      user.confirm
    end

    # Usuários NUPE, CGE, DDE com seus devidos perfis
    users = []
    users << { name: 'Sandra de Fátima Lucietti', email: 'sandra.lucietti@fraiburgo.ifc.edu.br', perfils: [Perfil.find_by(name: 'NUPE')] }
    users << { name: 'Débora de Lima Velho Junges', email: 'debora.junges@ifc.edu.br', perfils: [Perfil.find_by(name: 'NUPE')] }
    users << { name: 'Pedro dos Santos Faccin', email: 'pedro.faccin@ifc.edu.br', perfils: [Perfil.find_by(name: 'NUPE')] }
    users << { name: 'Coordenação Geral de Ensino', email: 'cge@fraiburgo.ifc.edu.br', perfils: [Perfil.find_by(name: 'DDE'), Perfil.find_by(name: 'CGE')] }
    users << { name: 'Tiago Gonçalves', email: 'tiago.goncalves@ifc.edu.br', admin:true, teacher:true, perfils: [Perfil.find_by(name: 'DDE')] }
    users << { name: 'Paulo Roberto Ribeiro Nunes', email: 'paulo.nunes@fraiburgo.ifc.edu.br', perfils: [Perfil.find_by(name: 'NUPE')] }

    users.each do |u, v|
      u[:username] = u[:email].split('@')[0]
      user = User.find_or_create_by(email: u[:email]) do |user|
        user.password               = u[:username]
        user.password_confirmation  = u[:username]
        user.perfils = u[:perfils]
        user.confirm
      end
    end

  end
end
