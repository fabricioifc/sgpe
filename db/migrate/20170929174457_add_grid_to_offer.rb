class AddGridToOffer < ActiveRecord::Migration[5.1]
  def change
    add_reference :offers, :grid, foreign_key: true, index:true
  end
end
