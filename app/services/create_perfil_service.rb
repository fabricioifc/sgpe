class CreatePerfilService

  def call
    acoes = { 'Gerenciar' => 'manage', 'Visualizar' => 'read', 'Excluir' => 'destroy', 'Editar' =>  'update', 'Criar' => 'create' }

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

    models.each do |m|
      acoes.each do |k,v|
        Role.find_or_create_by( name: k, resource_type: m.to_s, resource_id: v ) unless m.nil?
      end
    end

    papeis_perfil ||= []
    # Papéis do nupe
    papeis_perfil << { Perfil.find_or_create_by(name: 'NUPE').id => {
      manage: ['CourseOffer', 'CourseModality', 'CourseFormat', 'Course', 'Discipline', 'Turma'], read: ['Plan'] }
    }
    # Papéis do professor
    papeis_perfil << {Perfil.find_or_create_by(name: 'Professor').id => {
      manage: ['Plan'] }
    }


    # Salvar os papeis por perfil
    papeis_perfil.each do |p|
      p.each do |perfil_id, papeis|
        papeis.each do |k, v|
          Role.where(resource_id: k, resource_type: v).pluck(:id).each do |role_id|
            PerfilRole.find_or_create_by!(
              perfil_id: perfil_id,
              role_id: role_id
            )
          end
        end
      end
    end


    # papeis_perfil.each do |k, v|
    #   Role.where(resource_id: k, resource_type: v).pluck(:id).each do |role_id|
    #     PerfilRole.find_or_create_by!(
    #       perfil_id: perfil.id,
    #       role_id: role_id
    #     )
    #   end
    # end
    #
    # # Papéid do professor
    # perfil = Perfil.find_or_create_by(name: 'Professor')
    # papeis_perfil = { manage: ['Plan'] }
    # papeis_perfil.each do |k, v|
    #   Role.where(resource_id: k, resource_type: v).pluck(:id).each do |role_id|
    #     PerfilRole.find_or_create_by!(
    #       perfil_id: perfil.id,
    #       role_id: role_id
    #     )
    #   end
    # end

  end
end
