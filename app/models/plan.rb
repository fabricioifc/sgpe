class Plan < ApplicationRecord
  belongs_to :offer_discipline
  belongs_to :plan_class
  belongs_to :user

end
