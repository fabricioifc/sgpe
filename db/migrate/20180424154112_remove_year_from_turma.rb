class RemoveYearFromTurma < ActiveRecord::Migration[5.1]
  def change
    remove_column :turmas, :year
  end
end
