class ChangeNotNullFromGridDiscipline < ActiveRecord::Migration[5.1]
  def change
    change_column :grid_disciplines, :ementa,         :text, null:false
    change_column :grid_disciplines, :objetivo_geral, :text, null:false
    change_column :grid_disciplines, :bib_geral,      :text, null:false
    change_column :grid_disciplines, :bib_espec,      :text, null:false
  end
end
