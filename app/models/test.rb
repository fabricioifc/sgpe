class Test < ApplicationRecord

  def decorate
    @decorate ||= TestDecorator.new self
  end
end
