class CreatePerfils < ActiveRecord::Migration[5.1]
  def change
    create_table :perfils do |t|
      t.string :name, unique:true
      t.boolean :idativo, default:true

      t.timestamps
    end

    add_index(:perfils, :name)
  end
end
