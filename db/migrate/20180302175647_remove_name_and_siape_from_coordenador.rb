class RemoveNameAndSiapeFromCoordenador < ActiveRecord::Migration[5.1]
  def change
    remove_column :coordenadors, :name
    remove_column :coordenadors, :siape
  end
end
