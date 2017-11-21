class Turma < ApplicationRecord
#  has_many :offers

  validates :name, presence:true
  validates :year, presence: true,
    format: {
      with: /(19|20)\d{2}/i
    },
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1900,
      less_than_or_equal_to: Date.today.year + 25
    }

  validates :name, :year, uniqueness:true

  def decorate
    @decorate ||= TurmaDecorator.new self
  end
end
