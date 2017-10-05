class AddColumnsToOffer < ActiveRecord::Migration[5.1]
  def change
    add_column :offers, :year_base, :integer
    add_column :offers, :semestre_base, :integer
  end
end
