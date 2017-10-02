class AddOfferToOfferDiscipline < ActiveRecord::Migration[5.1]
  def change
    add_reference :offer_disciplines, :offer, foreign_key: true, index:true
  end
end
