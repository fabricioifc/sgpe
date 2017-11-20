class AddStatusToPlan < ActiveRecord::Migration[5.1]
  def change
    add_column :plans, :analise, :boolean, default:false, null:false, index:true
    add_column :plans, :aprovado, :boolean, default:false, null:false, index:true
    add_column :plans, :reprovado, :boolean, default:false, null:false, index:true
  end
end
