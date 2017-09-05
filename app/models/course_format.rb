class CourseFormat < ApplicationRecord

  validates :name, presence:true

  def decorate
    @decorate ||= CourseFormatDecorator.new self
  end
end
