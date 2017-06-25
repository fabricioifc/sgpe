class CreateCursos < ActiveRecord::Migration[5.1]
  def change
    create_table :cursos do |t|
      t.string :title
      t.string :sigla
      t.string :description
      t.boolean :idativo, default:true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
