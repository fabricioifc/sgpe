class CreateLessonRecurrings < ActiveRecord::Migration[5.1]
  def change
    create_table :lesson_recurrings do |t|
      t.date :dtinicio, null:false
      t.date :dtfim, null:false
      t.references :calendar, foreign_key: true, null:false, index:true
      t.references :turma, foreign_key: true, null:false, index:true
      t.references :offer, foreign_key: true, null:false, index:true
      t.boolean :active, null:false, default:true

      t.timestamps
    end
  end
end
