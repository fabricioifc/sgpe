class RemoveCourseFormatFromOffer < ActiveRecord::Migration[5.2]
  def change
    remove_column :offers, :course_format_id
  end
end
