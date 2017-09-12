class Grid < ApplicationRecord
  belongs_to :course
  belongs_to :user
  has_many :grid_disciplines
  has_many :disciplines, :through => :grid_disciplines

  validates :year, :active, :course, presence:true

  accepts_nested_attributes_for :grid_disciplines

  def decorate
    @decorate ||= GridDecorator.new self
  end
end
