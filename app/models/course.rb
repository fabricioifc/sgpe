class Course < ApplicationRecord
  belongs_to :course_modality
  belongs_to :course_format
  belongs_to :course_offer
  belongs_to :user
  has_many :grids

  validates :sigla, :name, :active, :carga_horaria, :course_modality_id, :course_format_id, :course_offer_id, presence:true
  validates :sigla, uniqueness:true
  validates :carga_horaria, :numericality => { :greater_than => 0 }

  def decorate
    @decorate ||= CourseDecorator.new self
  end
end
