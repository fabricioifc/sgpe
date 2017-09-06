class AddCourseOfferToCourses < ActiveRecord::Migration[5.1]
  def change
    add_reference :courses, :course_offer, foreign_key: true, index:true
  end
end
