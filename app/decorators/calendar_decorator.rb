class CalendarDecorator < ApplicationDecorator
  delegate_all
  attr_reader :component

  def initialize(component)
    @component = component
  end

  def active
    active_tag component.active?, 'fa-2'
  end

  def offer_name
    "#{component.offer.year} - #{component.offer.grid.course.name} - #{component.offer.decorate.type_offer}"
  end

  def name
    component.name
  end

  def dt_inicio
    l component.dt_inicio
  end

  def dt_fim
    l component.dt_fim
  end

end
