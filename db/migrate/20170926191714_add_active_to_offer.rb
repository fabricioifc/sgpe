class AddActiveToOffer < ActiveRecord::Migration[5.1]
  def change
    add_column :offers, :active, :boolean, default:true
  end
end
