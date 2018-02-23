class AddCoordenadorToPlan < ActiveRecord::Migration[5.1]
  def change
    add_reference :plans, :coordenador, foreign_key: true, index:true
  end
end
