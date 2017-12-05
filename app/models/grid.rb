class Grid < ApplicationRecord
  belongs_to :course
  belongs_to :user
  has_many :grid_disciplines, dependent: :destroy
  has_many :offers
  # has_many :disciplines, :through => :grid_disciplines

  validates :course_id, presence:true
  validates :year, presence: true,
    format: {
      with: /(19|20)\d{2}/i
    },
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1900,
      less_than_or_equal_to: Date.today.year + 25
    }

  validates :carga_horaria, presence:true, :numericality => { :greater_than => 0 }

  accepts_nested_attributes_for :grid_disciplines, :allow_destroy => true

  amoeba do
    enable
    include_association :grid_disciplines
  end

  default_scope { where(enabled: true) }

  def decorate
    @decorate ||= GridDecorator.new self
  end

  # def receipt
  #   Receipts::Receipt.new(
  #     id: id,
  #     product: "GoRails",
  #     company: {
  #       name: "One Month, Inc.",
  #       address: "37 Great Jones\nFloor 2\nNew York City, NY 10012",
  #       email: "teachers@onemonth.com",
  #       logo: Rails.root.join("app/assets/images/logo.png")
  #     },
  #     line_items: [
  #       ["Date",           created_at.to_s],
  #       # ["Account Billed", "#{user.name} (#{user.email})"],
  #       # ["Product",        "GoRails"],
  #       # ["Amount",         "$#{amount / 100}.00"],
  #       # ["Charged to",     "#{card_type} (**** **** **** #{card_last4})"],
  #       # ["Transaction ID", uuid]
  #     ],
  #     font: {
  #       # bold: Rails.root.join('app/assets/fonts/tradegothic/TradeGothic-Bold.ttf'),
  #       # normal: Rails.root.join('app/assets/fonts/tradegothic/TradeGothic.ttf'),
  #     }
  #   )
  # end
end
