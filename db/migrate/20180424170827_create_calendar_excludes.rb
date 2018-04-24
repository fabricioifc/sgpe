class CreateCalendarExcludes < ActiveRecord::Migration[5.1]
  def change
    create_table :calendar_excludes do |t|
      t.references :calendar, foreign_key: true, null:false, index:true
      t.date :dt_exclusao, null:false

      t.timestamps
    end
  end
end
