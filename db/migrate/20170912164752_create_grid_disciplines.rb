class CreateGridDisciplines < ActiveRecord::Migration[5.1]
  def change
    create_table :grid_disciplines do |t|
      t.integer :year, null:false
      t.text :ementa, null:false
      t.text :objetivo_geral, null:false
      t.text :bib_geral, null:false
      t.text :bib_espec, null:false
      t.references :grid, foreign_key: true, index:true
      t.references :discipline, foreign_key: true, index:true

      t.timestamps
    end
  end
end
