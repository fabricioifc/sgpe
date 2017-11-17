class CourseFormatDecorator < ApplicationDecorator
  delegate_all
  attr_reader :component

  def initialize(component)
    @component = component
  end

  def name
    component.name.capitalize
  end

end
