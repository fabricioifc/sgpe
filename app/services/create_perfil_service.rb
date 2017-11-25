class CreatePerfilService

  def call

    perfils = []
    perfils << [ name: 'DDE', idativo: true ]
    perfils << [ name: 'CGE', idativo: true ]

    perfils.each do |k, v|
      Perfil.find_or_create_by(k)
    end

    puts "Lista de perfis atualizada!"

    models ||= []
    ActiveRecord::Base.connection.tables.each do |v|
      models << v.singularize.camelize unless ['ArInternalMetadatum', 'SchemaMigration'].include?(v.singularize.camelize)
    end
    models.sort

    papeis ||= []
    models.each do |m|
      papeis << Role.find_or_create_by!( name: "Gerenciar #{m}", resource_type: m.to_s, resource_id: 'manage' ) unless m.nil?
    end

    # Papéis do nupe
    # perfil_papeis = {
    #   Perfil.find_by(name: 'NUPE').id => {
    #     Role.find_by(resource_id: 'manage', resource_type: 'CourseOffers')
    #     # Role.find_by(resource_id: 'manage', resource_type: 'CourseModality'),
    #     # Role.find_by(resource_id: 'manage', resource_type: 'CourseFormat'),
    #     # Role.find_by(resource_id: 'manage', resource_type: 'Discipline'),
    #     # Role.find_by(resource_id: 'manage', resource_type: 'Course'),
    #     # Role.find_by(resource_id: 'manage', resource_type: 'Turma')
    #   }
    # }


    # papeis.each do |papel|
    #   PerfilRole.find_or_create_by!(perfil: perfil, role: )
    # end


  end
end
