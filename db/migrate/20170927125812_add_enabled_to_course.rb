class AddEnabledToCourse < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :enabled, :boolean, default:true
  end
end
