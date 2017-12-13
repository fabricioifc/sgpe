class AddMaxEadToPlan < ActiveRecord::Migration[5.1]
  def change
    add_column :plans, :ead_percentual_definido, :integer, null:true
  end
end
