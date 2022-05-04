class Course < ApplicationRecord
  belongs_to :course_modality
  belongs_to :course_format
  belongs_to :course_offer
  belongs_to :user
  has_many :grids
  has_many :coordenadors

  validates :sigla, :name, :active, :course_modality, :course_format, :course_offer, presence:true
  validates :sigla, :name, :active, :course_modality, :course_format, :course_offer,
    uniqueness: {scope: [:sigla, :name, :active, :course_modality, :course_format, :course_offer]}
  validates :sigla, length: { in: 3..10}

  def decorate
    @decorate ||= CourseDecorator.new self
  end
end
