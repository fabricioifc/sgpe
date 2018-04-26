class UserDecorator < ApplicationDecorator
  delegate_all
  attr_reader :component

  def initialize(component)
    @component = component
  end

  def bio
    formatar_texto component.bio
    # ActionView::Base.full_sanitizer.sanitize(component.ementa.html_safe) unless component.ementa.nil?
  end

  def active
    active_tag component.invitation_token.nil?, 'fa-2' 
  end

end
