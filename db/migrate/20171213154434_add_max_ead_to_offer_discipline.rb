class AddMaxEadToOfferDiscipline < ActiveRecord::Migration[5.1]
  def change
    add_column :offer_disciplines, :ead_percentual_maximo,    :integer, null:true
  end
end
