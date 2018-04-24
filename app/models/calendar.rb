class Calendar < ApplicationRecord
  belongs_to :offer
  has_many :calendar_excludes, dependent: :destroy

  accepts_nested_attributes_for :calendar_excludes

  attr_accessor :dts_exclusao

  def decorate
    @decorate ||= CalendarDecorator.new self
  end
end
