class CreateCourseOffers < ActiveRecord::Migration[5.1]
  def change
    create_table :course_offers do |t|
      t.string :description, limit: 45, null:false
      t.boolean :active, default:true

      t.timestamps
    end
  end
end
