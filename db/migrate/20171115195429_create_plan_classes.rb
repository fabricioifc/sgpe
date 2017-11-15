class CreatePlanClasses < ActiveRecord::Migration[5.1]
  def change
    create_table :plan_classes do |t|
      t.string :name, limit: 45, null:false
      t.integer :ano, null:false
      t.boolean :active, null:false, default:true

      t.timestamps
    end
  end
end
