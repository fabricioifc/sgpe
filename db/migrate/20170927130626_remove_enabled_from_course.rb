class RemoveEnabledFromCourse < ActiveRecord::Migration[5.1]
  def change
    remove_column :courses, :enabled
  end
end
