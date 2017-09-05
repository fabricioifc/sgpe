class Course < ApplicationRecord
  belongs_to :course_modality
  belongs_to :course_format
  belongs_to :user

  validates :sigla, :name, :active, :carga_horaria, :course_modality_id, :course_format_id, presence:true

  def decorate
    @decorate ||= CursoDecorator.new self
  end
end
