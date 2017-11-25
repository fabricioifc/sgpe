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
    perfil = Perfil.find_or_create_by(name: 'NUPE')
    papeis_perfil = { manage: ['CourseOffer', 'CourseModality', 'CourseFormat', 'Course', 'Discipline', 'Turma'] }
    papeis_perfil.each do |k, v|
      Role.where(resource_id: k, resource_type: v).pluck(:id).each do |role_id|
        PerfilRole.find_or_create_by!(
          perfil_id: perfil.id,
          role_id: role_id
        )
      end
    end

    # Papéid do professor
    perfil = Perfil.find_or_create_by(name: 'Professor')
    papeis_perfil = { manage: ['Plan'] }
    papeis_perfil.each do |k, v|
      Role.where(resource_id: k, resource_type: v).pluck(:id).each do |role_id|
        PerfilRole.find_or_create_by!(
          perfil_id: perfil.id,
          role_id: role_id
        )
      end
    end

  end
end
