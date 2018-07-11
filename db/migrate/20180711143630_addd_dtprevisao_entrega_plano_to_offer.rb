class AdddDtprevisaoEntregaPlanoToOffer < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :dtprevisao_entrega_plano, :date
  end
end
