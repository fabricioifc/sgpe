class CreatePapeisPorUsuario < ActiveRecord::Migration[5.1]
  def change

    create_table :perfils do |t|
      t.string :name, index:true, unique:true, limit:45, null:false
      t.boolean :idativo, default:true

      t.timestamps
    end

    create_table :roles do |t|
      t.string :name, index:true, unique:true, limit:145, null:false
      t.string :resource_type, limit:100
      t.string :resource_id, limit:100

      t.timestamps
    end

    create_table(:perfil_roles) do |t|
      t.references :perfil, foreign_key: true, index:true
      t.references :role, foreign_key: true, index:true
    end

    create_table(:users_perfils) do |t|
      t.references :user, foreign_key: true, index:true
      t.references :perfil, foreign_key: true, index:true
    end

    add_index(:roles, [ :name, :resource_type, :resource_id ])
    add_index(:perfil_roles, [ :perfil_id, :role_id ], unique:true)
    add_index(:users_perfils, [ :perfil_id, :user_id ], unique:true)
  end
end
