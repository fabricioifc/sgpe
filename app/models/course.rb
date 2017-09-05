class Course < ApplicationRecord
  belongs_to :CourseModality
  belongs_to :CourseFormat
  belongs_to :user
end
