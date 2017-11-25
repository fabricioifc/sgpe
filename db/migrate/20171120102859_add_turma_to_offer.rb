class AddTurmaToOffer < ActiveRecord::Migration[5.1]
  def change
    add_reference :offers, :turma, foreign_key: true, index:true
  end
end
