class Permissao < ApplicationRecord

  ACTIONS = {
    'Gerenciar todos os recursos' =>  'manage',
		'Apenas visualizar'           =>  'read',
		'Apenas Excluir'              =>  'destroy',
		'Apenas Editar'               =>  'update',
		'Apenas Criar'                =>  'create'
	}

  rails_admin do
    field :acao, :enum do
      enum do
        ACTIONS
      end
    end
    field :classe, :enum do
      enum do
        classes = []
          ActiveRecord::Base.connection.tables.each do |v|
          	classes << v.singularize.camelize
          end
        classes.sort
      end
    end
    include_all_fields
  end

  def label_collection
		"#{classe} - #{acao}"
	end

end
