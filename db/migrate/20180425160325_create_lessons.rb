class CreateLessons < ActiveRecord::Migration[5.1]
  def change
    create_table :lessons do |t|
      t.references :lesson_recurring, foreign_key: true, index:true
      t.references :offer_discipline, foreign_key: true, index:true
      t.date :dtaula, null:false
      t.integer :frequency, default: 0
      t.integer :dia_semana
      t.integer :periodo
      t.boolean :active, null:false, default:true

      t.timestamps
    end
  end
end
