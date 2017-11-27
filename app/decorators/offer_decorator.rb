class OfferDecorator < ApplicationDecorator
  delegate_all
  attr_reader :component

  def initialize(component)
    @component = component
  end

  def ano_semestre
    component.semestre.nil? ? "#{component.year}" : "#{component.year}/#{component.semestre}"
  end

end
