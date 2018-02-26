class RemoveTurmaFromOffer < ActiveRecord::Migration[5.1]
  def change
    remove_column :offers, :turma_id
  end
end
