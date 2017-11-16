class Plan < ApplicationRecord
  belongs_to :offer_discipline
  belongs_to :turma
  belongs_to :user

end
