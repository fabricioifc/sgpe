class CourseOffer < ApplicationRecord
  has_many :courses

  validates :description, presence:true

  def decorate
    @decorate ||= CourseOfferDecorator.new self
  end

end
