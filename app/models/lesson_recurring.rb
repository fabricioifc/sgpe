class LessonRecurring < ApplicationRecord
  enum periodos: {
    "1°M" => 1, "2°M" => 2, "3°M" => 3, "4°M" => 4, "5°M" => 5,
    "1°V" => 6, "2°V" => 7, "3°V" => 8, "4°V" => 9, "5°V" => 10,
    "1°N" => 11, "2°N" => 12, "3°N" => 13, "4°N" => 14, "5°N" => 15,
  }
  enum dias: {"Segunda" => :segunda, "Terça" => :terca, "Quarta" => :quarta, "Quinta" => :quinta, "Sexta" => :sexta, "Sábado" => :sabado}

  belongs_to :calendar
  belongs_to :turma
  belongs_to :offer
  attr_accessor :periodos_selecionados, :dias_selecionados

  validates :dtinicio, :dtfim, :calendar_id, :turma_id, :offer_id, presence:true
  validates :calendar_id, :offer_id,
    uniqueness: {scope: [:calendar_id, :offer_id]}

  def decorate
    @decorate ||= LessonRecurringDecorator.new self
  end
end
