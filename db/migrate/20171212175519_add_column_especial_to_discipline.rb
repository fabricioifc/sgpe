class AddColumnEspecialToDiscipline < ActiveRecord::Migration[5.1]
  def change
    add_column :disciplines, :especial, :boolean, default:false, null:false
  end
end
