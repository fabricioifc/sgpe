class PlanClass < ApplicationRecord

  validates :name, :active, presence:true
  validates :ano, presence:true,
    format: {
      with: /(19|20)\d{2}/i
    },
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1900,
      less_than_or_equal_to: Date.today.year + 25
    }

  def decorate
    @decorate ||= CourseDecorator.new self
  end
end
