class GridDiscipline < ApplicationRecord
  belongs_to :grid
  belongs_to :discipline

  # accepts_nested_attributes_for :grid

  validates :ementa, :objetivo_geral, :bib_geral, :bib_espec, :discipline_id, presence:true
  validates :year, presence: true,
    format: {
      with: /(19|20)\d{2}/i
    },
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1900,
      less_than_or_equal_to: Date.today.year + 50
    }

  def decorate
    @decorate ||= GridDisciplineDecorator.new self
  end
end
