class CreatePermissaoTelas < ActiveRecord::Migration[5.1]
  def change
    create_table :permissao_telas do |t|
      t.references :permissao, foreign_key: true, index: true
      t.references :perfil, foreign_key: true, index: true

      t.timestamps
    end
  end
end
