class GridDiscipline < ApplicationRecord
  belongs_to :grid
  belongs_to :discipline
  has_many :offer_disciplines

  # accepts_nested_attributes_for :grid

  validates :discipline_id, :carga_horaria, presence:true
  validates :year, presence: { if: -> { semestre.blank? } }
  validates :semestre, presence: { if: -> { year.blank? } }

  # validates :ementa, :objetivo_geral, :bib_geral, :bib_espec, html: { presence: true }
  validates :ementa, :objetivo_geral, :bib_geral, :bib_espec, html: { presence: true }, if: Proc.new { |a| !a.discipline.especial? }

  def decorate
    @decorate ||= GridDisciplineDecorator.new self
  end
end
