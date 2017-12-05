class AddCargaHorariaToGrid < ActiveRecord::Migration[5.1]
  def change
    add_column :grids, :carga_horaria, :integer
  end
end
