class Lesson < ApplicationRecord
  belongs_to :lesson_recurring
  belongs_to :offer_discipline
  enum frequency: { semanalmente: 0, mensalmente: 1 }

  validates :lesson_recurring_id, :offer_discipline_id, :dtaula, :frequency, :dia_semana, :periodo, presence:true

  def decorate
    @decorate ||= LessonDecorator.new self
  end

end
