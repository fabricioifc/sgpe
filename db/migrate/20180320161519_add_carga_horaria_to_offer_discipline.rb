class AddCargaHorariaToOfferDiscipline < ActiveRecord::Migration[5.1]
  def change
    add_column :offer_disciplines, :carga_horaria, :integer
  end
end
