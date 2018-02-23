class RemoveDtinicioAndDtfimFromCoordenador < ActiveRecord::Migration[5.1]
  def change
    remove_column :coordenadors, :dtinicio, :date
    remove_column :coordenadors, :dtfim, :date
  end
end
