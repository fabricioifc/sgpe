class CreateOffers < ActiveRecord::Migration[5.1]
  def change
    create_table :offers do |t|
      t.integer :year
      t.integer :semestre
      t.string :type, null:false
      t.references :course, foreign_key: true, index:true

      t.timestamps
    end
  end
end
