class Turma < ApplicationRecord

  validates :name, :year, presence:true

  def decorate
    @decorate ||= TurmaDecorator.new self
  end
end
