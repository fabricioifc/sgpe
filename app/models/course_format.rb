class CourseFormat < ApplicationRecord
  has_many :courses

  validates :name, :minutos_aula, presence:true
  validates :minutos_aula, :numericality => { :greater_than => 0 }

  def decorate
    @decorate ||= CourseFormatDecorator.new self
  end
end
