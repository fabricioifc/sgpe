class RemovePlanClassFromPlan < ActiveRecord::Migration[5.1]
  def change
    remove_column :plans, :plan_class_id
  end
end
