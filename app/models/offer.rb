class Offer < ApplicationRecord
  belongs_to :course

  enum offer_types: [:tipo1, :tipo2]

  validates :course_id, :type, presence:true
  validates :semestre, presence: { if: -> { year.blank? } }

  validates :year, presence: { if: -> { semestre.blank? } },
    format: {
      with: /(19|20)\d{2}/i
    },
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1900,
      less_than_or_equal_to: Date.today.year + 25
    }

  # accepts_nested_attributes_for :grid_disciplines, :allow_destroy => true

  def decorate
    @decorate ||= GridDecorator.new self
  end
end
