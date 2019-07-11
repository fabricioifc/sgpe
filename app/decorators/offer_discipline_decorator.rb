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
    carga_horaria_aula_generic(
      component.offer.course_format.nil? ? component.grid_discipline.grid.course.course_format.minutos_aula : component.offer.course_format.minutos_aula, 
      value)
  end

  def carga_horaria_aula_text
    # value = component.carga_horaria || component.grid_discipline.carga_horaria
    carga_horaria_aula.to_s << ' H/A'
  end  

  def professores
    professores = component.user.name unless component.user.nil?
    if !component.second_user.nil?
      professores = professores.nil? ? '' : professores.concat(', ')
      professores = professores.concat(component.second_user.name)
    end
    professores
    
  end
  


end
