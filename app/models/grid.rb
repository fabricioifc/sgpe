class Grid < ApplicationRecord
  belongs_to :course
  belongs_to :user
  has_many :grid_disciplines, dependent: :destroy
  has_many :offers
  # has_many :disciplines, :through => :grid_disciplines

  validates :course_id, presence:true
  validates :year, presence: true,
    format: {
      with: /(19|20)\d{2}/i
    },
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1900,
      less_than_or_equal_to: Date.today.year + 25
    }

  validates :carga_horaria, presence:true, :numericality => { :greater_than => 0 }
  # Grade única por ano e curso
  validates :year, :course_id, uniqueness: {scope: [:year, :course_id]}

  accepts_nested_attributes_for :grid_disciplines, :allow_destroy => true

  amoeba do
    enable
    include_association :grid_disciplines
  end

  default_scope { where(enabled: true) }

  def decorate
    @decorate ||= GridDecorator.new self
  end

end
