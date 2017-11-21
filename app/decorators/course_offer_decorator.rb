class CourseOfferDecorator < ApplicationDecorator
  delegate_all
  attr_reader :component

  def initialize(component)
    @component = component
  end

  def description
    component.description.humanize
  end

  def active
    active_tag component.active?, 'fa-2'
  end

end
