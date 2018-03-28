class OfferDisciplineDecorator < ApplicationDecorator
  delegate_all
  attr_reader :component

  def initialize(component)
    @component = component
  end


  def carga_horaria_hora_text
    value = component.carga_horaria || component.grid_discipline.carga_horaria
    value.to_s << ' H'
  end

  def carga_horaria_aula
    value = component.carga_horaria || component.grid_discipline.carga_horaria
    carga_horaria_aula_generic(component.grid_discipline.grid.course.course_format.minutos_aula, value)
  end

  def carga_horaria_aula_text
    # value = component.carga_horaria || component.grid_discipline.carga_horaria
    carga_horaria_aula.to_s << ' H/A'
  end


end
