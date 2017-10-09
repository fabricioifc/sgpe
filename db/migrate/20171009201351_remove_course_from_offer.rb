class RemoveCourseFromOffer < ActiveRecord::Migration[5.1]
  def change
    remove_column :offers, :course_id
  end
end
