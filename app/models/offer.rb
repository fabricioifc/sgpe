class Offer < ApplicationRecord
  belongs_to :course
  belongs_to :grid
  has_many :offer_disciplines, dependent: :destroy
  accepts_nested_attributes_for :offer_disciplines

  enum offer_types: [:tipo1, :tipo2]

  validates :type_offer, :grid_id, presence:true
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

  attr_accessor :grid_year, :grid_semestre

  def attributes
    super.merge(
      'grid_year' => self.grid_year,
      'grid_semestre' => self.grid_semestre,
      'offer_disciplines' => self.offer_disciplines.build
    )
  end
end
