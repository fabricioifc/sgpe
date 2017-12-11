class AlterTitleFromDiscipline < ActiveRecord::Migration[5.1]
  def change
    change_column :disciplines, :title, :string, null:false, limit: 255
  end
end
