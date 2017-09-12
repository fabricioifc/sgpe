class Grid < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates :year, :active, :course, presence:true

  def decorate
    @decorate ||= GridDecorator.new self
  end
end
