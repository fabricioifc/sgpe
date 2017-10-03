module Wizard
  module Offer
    STEPS = %w(step1 step2 step3 step4).freeze

    class Base
      include ActiveModel::Model
      attr_accessor :offer
      attr_accessor :grid_year, :grid_semestre

      delegate *::Offer.attribute_names.map { |attr|
        [attr, "#{attr}="]
      }.flatten, to: :offer

      delegate :grid_year, :grid_semestre, to: :offer

      def initialize(offer_attributes)
        binding.pry
        @offer = ::Offer.new(offer_attributes)
        @offer.offer_disciplines.build
      end
    end

    class Step1 < Base
      validates :grid_id, presence: true
    end

    class Step2 < Step1
      validates :grid_year, presence: { if: -> { grid_semestre.blank? } }
      validates :grid_semestre, presence: { if: -> { grid_year.blank? } }
    end

    class Step3 < Step2
      # validates :user_id, presence: true
    #   validates :address_1, presence: true
    #   validates :zip_code, presence: true
    #   validates :city, presence: true
    #   validates :country, presence: true
    end
    #
    class Step4 < Step3
    #   validates :phone_number, presence: true
    end
  end
end
