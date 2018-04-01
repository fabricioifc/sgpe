class InviteUsersService

  def call

    # O admin envia o convite para os usuários
    admin = User.where(admin:true).first
    if admin.nil?
      puts 'Nenhum administrador encontrado para ser utilizado no envio dos convites!'
      return
    end

    users = []
    users << User.new( name: 'Adriela Maria Noronha', siape: '2389152', email: 'adriela.noronha@ifc.edu.br', perfils: [Perfil.find_by(name: 'Professor')])
    users << User.new( name: 'André Toreli Salatino', siape: '1494345', email: 'andre.salatino@ifc.edu.br', perfils: [Perfil.find_by(name: 'Professor')])
    users << User.new( name: 'Cícero José de Oliveira Lima', siape: '2250986', email: 'cicero.lima@ifc.edu.br', perfils: [Perfil.find_by(name: 'Professor')])
    users << User.new( name: 'Claudio Bertotto', siape: '2163953', email: 'claudio.bertotto@ifc.edu.br', perfils: [Perfil.find_by(name: 'Professor')])
    users << User.new( name: 'Débora dos Santos', siape: '1885619', email: 'debora.santos@ifc.edu.br', perfils: [Perfil.find_by(name: 'Professor')])
    users << User.new( name: 'Elaine Ribeiro', siape: '2059166', email: 'elaine.ribeiro@ifc.edu.br', perfils: [Perfil.find_by(name: 'Professor')])
    users << User.new( name: 'Fábio José Rodrigues Pinheiro', siape: '1759928', email: 'fabio.pinheiro@ifc.edu.br', perfils: [Perfil.find_by(name: 'Professor')])
    users << User.new( name: 'Fabricio Bizotto', siape: '1087004', email: 'fabricio.bizotto@ifc.edu.br', perfils: [Perfil.find_by(name: 'Professor')])
    users << User.new( name: 'Felipe de Oliveira Lamberg Henriques dos Santos', siape: '2187272', email: ' felipe.santos@ifc.edu.br', perfils: [Perfil.find_by(name: 'Professor')])
    users << User.new( name: 'Genildo Nascimento dos Santos', siape: '2269654', email: 'genildo.santos@ifc.edu.br', perfils: [Perfil.find_by(name: 'Professor')])
    users << User.new( name: 'Gilberto Speggiorin de Oliveira', siape: '1924028', email: 'gilberto.oliveira@ifc.edu.br', perfils: [Perfil.find_by(name: 'Professor')])
    users << User.new( name: 'Itamar Antonio Rodrigues', siape: '1893292', email: 'itamar.rodrigues@ifc.edu.br', perfils: [Perfil.find_by(name: 'Professor')])
    users << User.new( name: 'Jacob Michels', siape: '1046843', email: 'jacob.michels@ifc.edu.br', perfils: [Perfil.find_by(name: 'Professor')])
    users << User.new( name: 'Josias Reis Lima', siape: '1878471', email: 'josias.lima@ifc.edu.br', perfils: [Perfil.find_by(name: 'Professor')])
    users << User.new( name: 'Maria Paula Seibel Brock', siape: '1073708', email: 'maria.brock@ifc.edu.br', perfils: [Perfil.find_by(name: 'Professor')])
    users << User.new( name: 'Marlon Cordeiro Domenech', siape: '2189289', email: 'marlon.domenech@ifc.edu.br', perfils: [Perfil.find_by(name: 'Professor')])
    users << User.new( name: 'Mirela Bernieri', siape: '3616051', email: 'mirela.bernieri@ifc.edu.br', perfils: [Perfil.find_by(name: 'Professor')])
    users << User.new( name: 'Paulo Soares da Costa', siape: '2258578', email: 'paulo.costa@ifc.edu.br', perfils: [Perfil.find_by(name: 'Professor')])
    users << User.new( name: 'Rafael Leonardo Vivian', siape: '1005652', email: 'rafael.vivian@ifc.edu.br', perfils: [Perfil.find_by(name: 'Professor')])
    users << User.new( name: 'Rafael Vinícius Martins', siape: '2396232', email: 'rafael.martins@ifc.edu.br', perfils: [Perfil.find_by(name: 'Professor')])
    users << User.new( name: 'Ricardo Annes', siape: '1776240', email: 'ricardo.annes@ifc.edu.br', perfils: [Perfil.find_by(name: 'Professor')])
    users << User.new( name: 'Ricardo Beal', siape: '2163994', email: 'ricardo.beal@ifc.edu.br', perfils: [Perfil.find_by(name: 'Professor')])
    users << User.new( name: 'Rodrigo Espinosa Cabral', siape: '2059612', email: 'rodrigo.cabral@ifc.edu.br', perfils: [Perfil.find_by(name: 'Professor')])
    users << User.new( name: 'Suelen Ribeiro Galdino', siape: '2395635', email: 'suelen.galdino@ifc.edu.br', perfils: [Perfil.find_by(name: 'Professor')])
    users << User.new( name: 'Tiago Lopes Gonçalves', siape: '1905449', email: 'tiago.goncalves@ifc.edu.br', perfils: [Perfil.find_by(name: 'Professor')])
    users << User.new( name: 'Vanderlei Cristiano Juraski', siape: '2258605', email: 'vanderlei.juraski@ifc.edu.br', perfils: [Perfil.find_by(name: 'Professor')])
    users << User.new( name: 'Vladimir Schuindt da Silva', siape: '1533931', email: 'vladimir.silva@fraiburgo.ifc.edu.br', perfils: [Perfil.find_by(name: 'Professor')])
    users << User.new( name: 'Carolina de Moraes da Trindade', siape: '', email: 'carolina.trindade@ifc.edu.br', perfils: [Perfil.find_by(name: 'Professor')])
    users << User.new( name: 'Rodimar Garbin', siape: '', email: 'rodimar.garbin@ifc.edu.br', perfils: [Perfil.find_by(name: 'Professor')])

    users << User.new( name: 'Dheime Romanatto Trevisol', siape: '2172977', email: 'dheime.trevisol@ifc.edu.br', perfils: [Perfil.find_by(name: 'NUPE')])
    users << User.new( name: 'Juceli Baldissera Felckilcker', siape: '1893151', email: 'juceli.felckilcker@ifc.edu.br', perfils: [Perfil.find_by(name: 'NUPE')])

    users.each do |u, v|
      if User.find_by(email: u.email).nil?
        u.username               = u.email.split('@')[0]
        # u.password               = senha_padrao
        # u.password_confirmation  = senha_padrao
        u.perfils                = u.perfils
        # u.confirm
        # u.save!
        u.invite!(admin)
      end
    end

  end
end
