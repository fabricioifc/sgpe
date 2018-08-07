class AddDatasToCoordenador < ActiveRecord::Migration[5.2]
  def change
    add_column :coordenadors, :dtinicio, :date
    add_column :coordenadors, :dtfim, :date
  end
end
