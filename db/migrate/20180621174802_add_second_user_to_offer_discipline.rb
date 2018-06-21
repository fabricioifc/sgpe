class AddSecondUserToOfferDiscipline < ActiveRecord::Migration[5.2]
  def change
    # add_reference :offer_disciplines, :user_id, foreign_key: true
    add_reference :offer_disciplines, :second_user, foreign_key: { to_table: :users }
  end
end
