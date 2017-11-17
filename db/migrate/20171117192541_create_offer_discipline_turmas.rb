class CreateOfferDisciplineTurmas < ActiveRecord::Migration[5.1]
  def change
    create_table :offer_discipline_turmas do |t|
      t.references :offer_discipline, foreign_key: true
      t.references :turma, foreign_key: true

      t.timestamps
    end
  end
end
