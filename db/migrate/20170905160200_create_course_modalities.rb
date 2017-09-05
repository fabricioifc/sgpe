class CreateCourseModalities < ActiveRecord::Migration[5.1]
  def change
    create_table :course_modalities do |t|
      t.string :sigla, limit: 5, null:false
      t.string :description, limit: 30, null:false, index:true

      t.timestamps
    end
  end
end
