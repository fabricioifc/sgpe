class CourseModality < ApplicationRecord
  has_many :courses

  validates :sigla, :description, presence:true

  def decorate
    @decorate ||= CourseModalityDecorator.new self
  end

end
