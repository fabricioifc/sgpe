class Discipline < ApplicationRecord
  belongs_to :user

  validates :title, :description, :user, presence:true

  def decorate
    @decorate ||= DisciplineDecorator.new self
  end
end
