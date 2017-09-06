class PerfilDecorator < ApplicationDecorator
  delegate_all
  attr_reader :component

  def initialize(component)
    @component = component
  end

  def name
    component.name.capitalize
  end

  def idativo
    active_tag component.idativo?, 'fa-2'
  end

end
