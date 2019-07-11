class AddMinutesToOffer < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :minutos_aula, :int
  end
end
