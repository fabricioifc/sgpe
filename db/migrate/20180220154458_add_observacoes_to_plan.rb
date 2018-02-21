class AddObservacoesToPlan < ActiveRecord::Migration[5.1]
  def change
    add_column :plans, :observacoes, :text, null:true
  end
end
