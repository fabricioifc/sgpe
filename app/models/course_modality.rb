class CourseModality < ApplicationRecord

  validates :sigla, :description, presence:true

  def decorate
    @decorate ||= CourseModalityDecorator.new self
  end

end
