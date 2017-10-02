class OfferDiscipline < ApplicationRecord
  belongs_to :offer
  belongs_to :grid_discipline
  belongs_to :user

  # Usuários vinculados a disciplina devem ser professores
  # scope :teacher, -> {
  #       joins(:user).where("users.teacher is true")
  # }

  # grid_discipline, user(teacher) active

end
