class AddEnabledToGrid < ActiveRecord::Migration[5.1]
  def change
    add_column :grids, :enabled, :boolean, default:true
  end
end
