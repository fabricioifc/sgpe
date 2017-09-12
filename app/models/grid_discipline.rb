class GridDiscipline < ApplicationRecord
  belongs_to :grid
  belongs_to :discipline

  accepts_nested_attributes_for :grid
end
