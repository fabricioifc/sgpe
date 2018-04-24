class CreateCalendars < ActiveRecord::Migration[5.1]
  def change
    create_table :calendars do |t|
      t.string :name, null:false, limit:150
      t.references :offer, foreign_key: true, index:true, null:false
      t.date :dt_inicio, null:false
      t.date :dt_fim, null:false
      t.boolean :active, null:false, default:true

      t.timestamps
    end
  end
end
