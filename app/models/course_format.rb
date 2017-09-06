class CourseFormat < ApplicationRecord
  has_many :courses

  validates :name, presence:true

  def decorate
    @decorate ||= CourseFormatDecorator.new self
  end
end
