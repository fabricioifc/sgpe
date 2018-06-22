class OfferDecorator < ApplicationDecorator
  delegate_all
  attr_reader :component

  def initialize(component)
    @component = component
  end

  def ano_semestre
    component.semestre.nil? ? "#{component.year}" : "#{component.year}/#{component.semestre}"
  end

  def type_offer
    Offer.offer_types[component.type_offer] || component.type_offer
  end

  def active
    active_tag component.active?, 'fa-2'
  end

end
