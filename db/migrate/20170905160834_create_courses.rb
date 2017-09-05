class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :name, limit: 100, null:false, index:true
      t.string :sigla, limit: 5, null:false
      t.boolean :active, default:true
      t.integer :carga_horaria, null:false
      t.references :course_modality, foreign_key: true, index:true
      t.references :course_format, foreign_key: true, index:true
      t.references :user, foreign_key: true, index:true

      t.timestamps
    end
  end
end
