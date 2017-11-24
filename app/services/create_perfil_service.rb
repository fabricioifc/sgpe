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

    models.each do |m|
      Role.find_or_create_by!( name: "Gerenciar #{m}", resource_type: m.to_s, resource_id: 'manage' ) unless m.nil?
    end



  end
end
