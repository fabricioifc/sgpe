class GridDiscipline < ApplicationRecord
  belongs_to :grid
  belongs_to :discipline

  accepts_nested_attributes_for :grid

  validates :year, :ementa, :objetivo_geral, :bib_geral, :bib_espec, :discipline_id, presence:true
end
