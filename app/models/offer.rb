class Offer < ApplicationRecord
  belongs_to :grid
  belongs_to :turma
  has_many :offer_disciplines, dependent: :destroy
  accepts_nested_attributes_for :offer_disciplines

  enum offer_types: ['Regular', 'Não Regular']

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

  validates :offer_disciplines, presence:true#, on: [:update]
  validates :turma_id, presence:true
  validates :grid_id,
    uniqueness: {
      scope: [:turma_id, :year, :semestre, :grid_id],
      conditions: -> { where(active: true) },
      message: lambda { |x, y| "Já existe grade ofertada para esta turma, ano e semestre." }
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
