class Role < ApplicationRecord
  # has_and_belongs_to_many :users, :join_table => :users_roles
  # has_and_belongs_to_many :perfils, :join_table => :users_perfils

  # belongs_to :resource,
  #            :polymorphic => true,
  #            :optional => true

  # validates :resource_type,
  #           :inclusion => { :in => Rolify.resource_types },
  #           :allow_nil => true

  scopify

  validates :name, :resource_type, presence:true
  validates :resource_type, :resource_id, uniqueness: {scope: [:resource_type, :resource_id]}

  ACTIONS = {
    'Gerenciar'                   => 'manage',
		'Visualizar'                  => 'read',
		'Excluir'                     => 'destroy',
		'Atualizar'                   => 'update',
		'Criar'                       => 'create',
    'Editar'                      => 'edit',
    'Novo'                        => 'novo',
    'Aprovar planos'              => 'aprovar_reprovar',
    'Ver planos por curso'        => 'planos_curso',
    'Ver planos por professor'    => 'planos_professor',
	}

  rails_admin do
    field :resource_id, :enum do
      enum do
        ACTIONS
      end
    end
    field :resource_type, :enum do
      enum do
        models ||= []
          ActiveRecord::Base.connection.tables.each do |v|
            models << v.singularize.camelize unless ['ArInternalMetadatum', 'SchemaMigration'].include?(v.singularize.camelize)
          end
        models.sort
      end
    end
    include_all_fields
  end

  def label_collection
		"#{resource_type} - #{resource_id}"
	end

end
