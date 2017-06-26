class AddIndexToPermissaosTelas < ActiveRecord::Migration[5.1]
  def change
    add_index(:permissao_telas, [ :permissao_id, :perfil_id ], unique: true)
  end
end
