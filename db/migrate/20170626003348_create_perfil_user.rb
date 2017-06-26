class CreatePerfilUser < ActiveRecord::Migration[5.1]
  def change
    create_table :perfil_users, :id => false do |t|
      t.references :user, foreign_key: true, index: true
      t.references :perfil, foreign_key: true, index: true

    end
    add_index(:perfil_users, [ :user_id, :perfil_id ], unique: true)
  end
end
