class DropTableOfferDisciplineTurmas < ActiveRecord::Migration[5.1]
  def change
    drop_table :offer_discipline_turmas
  end
end
