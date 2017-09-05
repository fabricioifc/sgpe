class CreateDisciplines < ActiveRecord::Migration[5.1]
  def change
    create_table :disciplines do |t|
      t.string :title, null:false, limit:45
      t.string :sigla, null:false
      t.boolean :active, default:true
      t.references :user, foreign_key: true, index:true

      t.timestamps
    end
  end
end
