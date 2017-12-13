class Role < ApplicationRecord
  include PermissaosHelper
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
    'Ver planos curso'        => 'planos_curso',
    'Ver planos professor'    => 'planos_professor'
	}

  rails_admin do
    field :resource_id, :enum do
      enum do
        ACTIONS
      end
    end
    field :resource_type, :enum do
      enum do
        get_models
      end
    end
    include_all_fields
  end

  def label_collection
		"#{resource_type} - #{resource_id}"
	end

end
