class Curso < ApplicationRecord
  belongs_to :user
  paginates_per 2

  validates :title, :sigla, :description, presence:true

  def decorate
    @decorate ||= CursoDecorator.new self
  end
end
