class ChangeCourseFornatName < ActiveRecord::Migration[5.1]
  def change
    change_column :course_formats, :name, :string, :limit => 150
  end
end
