class CreatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :plans do |t|
      t.references :offer_discipline, foreign_key: true, index:true
      # t.references :plan_class, foreign_key: true, index:true, null:true
      t.text :obj_espe
      t.text :conteudo_prog
      t.text :prat_prof
      t.text :interdisc
      t.text :met_tec
      t.text :met_met
      t.text :avaliacao
      t.text :cronograma
      t.text :atendimento
      t.integer :versao
      t.boolean :active
      t.references :user, foreign_key: true, index:true # Usuário que cria o plano

      t.timestamps
    end
  end
end
