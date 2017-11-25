class DropColumnTurmaFromPlan < ActiveRecord::Migration[5.1]
  def change
    remove_column :plans, :turma_id
  end
end
