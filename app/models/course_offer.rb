class CourseOffer < ApplicationRecord
  has_many :courses

  enum tipos: [ :anual, :semestral, :ciclo, :oferta_unica ]

  validates :description, presence:true

  def decorate
    @decorate ||= CourseOfferDecorator.new self
  end

end
