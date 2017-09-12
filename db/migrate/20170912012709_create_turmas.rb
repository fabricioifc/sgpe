class CreateTurmas < ActiveRecord::Migration[5.1]
  def change
    create_table :turmas do |t|
      t.string :name, limit: 45, null:false, index:true
      t.integer :year, null:false
      t.boolean :active, default:true

      t.timestamps
    end
  end
end
