class CreateCourseFormats < ActiveRecord::Migration[5.1]
  def change
    create_table :course_formats do |t|
      t.string :name, limit: 45, null:false, index:true

      t.timestamps
    end
  end
end
