class Role < ApplicationRecord
  has_and_belongs_to_many :users, :join_table => :users_roles

  # belongs_to :resource,
  #            :polymorphic => true,
  #            :optional => true

  # validates :resource_type,
  #           :inclusion => { :in => Rolify.resource_types },
  #           :allow_nil => true

  scopify

  validates :resource_type, presence:true

  ACTIONS = {
    'Gerenciar todos os recursos' =>  'manage',
		'Apenas visualizar'           =>  'read',
		'Apenas Excluir'              =>  'destroy',
		'Apenas Editar'               =>  'update',
		'Apenas Criar'                =>  'create'
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
