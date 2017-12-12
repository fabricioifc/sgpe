class DisciplineDecorator < ApplicationDecorator
  delegate_all
  attr_reader :component

  def initialize(component)
    @component = component
  end

  def title
    component.title.capitalize
  end

  def active
    active_tag component.active?, 'fa-2'
  end

  def especial
    active_tag component.especial?, 'fa-2'
  end
end
