class CursoDecorator < ApplicationDecorator
  delegate_all
  attr_reader :component

  def initialize(component)
    @component = component
  end

  def title
    component.title.capitalize
  end

  def active
    if component.idativo?
      h.content_tag(:i, nil, class: 'fa fa-check-square')
    else
      h.content_tag :i, nil, class: 'fa fa-check-square'
    end
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end


end
