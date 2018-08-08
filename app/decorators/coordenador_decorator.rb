class CoordenadorDecorator < ApplicationDecorator
  delegate_all
  attr_reader :component

  def initialize(component)
    @component = component
  end

  def name
    component.name.capitalize
  end

  def responsavel
    active_tag component.responsavel?, 'fa-2'
  end

  def titular
    active_tag component.titular?, 'fa-2'
  end
end
