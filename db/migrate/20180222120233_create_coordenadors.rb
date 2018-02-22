class CreateCoordenadors < ActiveRecord::Migration[5.1]
  def change
    create_table :coordenadors do |t|
      t.string :name, null:false
      t.string :funcao, null:false
      t.string :siape, null:false
      t.boolean :titular, default:true
      t.string :email, null:false
      t.date :dtinicio
      t.date :dtfim
      t.boolean :responsavel, default:true

      t.timestamps
    end
  end
end
