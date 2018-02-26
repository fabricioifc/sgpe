class AddTurmaDescToOffer < ActiveRecord::Migration[5.1]
  def change
    add_column :offers, :turma, :string
  end
end
