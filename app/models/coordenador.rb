class Coordenador < ApplicationRecord
  belongs_to :course

  validates :name, :course_id, :funcao, :siape, :email, :dtinicio, :dtfim, presence:true
  validates :course_id, :titular,
    uniqueness: {scope: [:course_id, :titular]}

  # validates :dtinicio, date: { before_or_equal_to: Proc.new { :dtfim } }
  validates :dtfim, date: { after_or_equal_to: Proc.new { :dtinicio } }
  validates :dtinicio, date: { before_or_equal_to: :dtfim }

  def decorate
    @decorate ||= CoordenadorDecorator.new self
  end

end
