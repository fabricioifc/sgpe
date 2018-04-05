class Discipline < ApplicationRecord
  belongs_to :user
  has_many :grid_disciplines
  # has_many :grids#, :through => :grid_disciplines

  validates :title, :sigla, :user, presence:true
  validates :title, uniqueness:true

  def decorate
    @decorate ||= DisciplineDecorator.new self
  end
end
