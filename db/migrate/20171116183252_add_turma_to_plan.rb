class AddTurmaToPlan < ActiveRecord::Migration[5.1]
  def change
    add_reference :plans, :turma, foreign_key: true, index:true
  end
end
