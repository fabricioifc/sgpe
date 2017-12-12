class ChangeNotNullFromGridDiscipline2 < ActiveRecord::Migration[5.1]
  def change
    change_column :grid_disciplines, :ementa,         :text, null:true
    change_column :grid_disciplines, :objetivo_geral, :text, null:true
    change_column :grid_disciplines, :bib_geral,      :text, null:true
    change_column :grid_disciplines, :bib_espec,      :text, null:true
  end
end
