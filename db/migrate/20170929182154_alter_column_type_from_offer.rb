class AlterColumnTypeFromOffer < ActiveRecord::Migration[5.1]
  def change
    rename_column :offers, :type, :type_offer
  end
end
