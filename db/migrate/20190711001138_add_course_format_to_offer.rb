class AddCourseFormatToOffer < ActiveRecord::Migration[5.2]
  def change
    add_reference :offers, :course_format, foreign_key: true, index:true
  end
end
