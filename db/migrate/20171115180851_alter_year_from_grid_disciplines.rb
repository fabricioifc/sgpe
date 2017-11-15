class AlterYearFromGridDisciplines < ActiveRecord::Migration[5.1]
  def change
    change_column :grid_disciplines, :year, :integer, null:true
  end
end
