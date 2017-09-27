class GridDiscipline < ApplicationRecord
  belongs_to :grid
  belongs_to :discipline

  # accepts_nested_attributes_for :grid

  validates :ementa, :objetivo_geral, :bib_geral, :bib_espec, :discipline_id, :carga_horaria, presence:true
  validates :year, presence: { if: -> { semestre.blank? } }
  validates :semestre, presence: { if: -> { year.blank? } }

  def decorate
    @decorate ||= GridDisciplineDecorator.new self
  end
end
