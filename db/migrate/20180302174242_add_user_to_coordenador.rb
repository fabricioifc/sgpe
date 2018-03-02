class AddUserToCoordenador < ActiveRecord::Migration[5.1]
  def change
    add_reference :coordenadors, :user, foreign_key: true
  end
end
