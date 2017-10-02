class CreateOfferDisciplines < ActiveRecord::Migration[5.1]
  def change
    create_table :offer_disciplines do |t|
      t.references :grid_discipline, foreign_key: true, index:true
      t.references :user, foreign_key: true, index:true
      t.boolean :active, default:true

      t.timestamps
    end
  end
end
