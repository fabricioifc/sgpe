class AddColumnsToGridDiscipline < ActiveRecord::Migration[5.1]
  def change
    add_column :grid_disciplines, :semestre, :integer
    add_column :grid_disciplines, :carga_horaria, :integer
  end
end
