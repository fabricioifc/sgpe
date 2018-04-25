class RemoveOfferFromCalendar < ActiveRecord::Migration[5.1]
  def change
    remove_column :calendars, :offer_id
  end
end
