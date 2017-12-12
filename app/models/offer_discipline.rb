class OfferDiscipline < ApplicationRecord
  belongs_to :offer
  belongs_to :grid_discipline
  belongs_to :user, optional:true
  has_many :plans

  accepts_nested_attributes_for :grid_discipline

  # validates :user_id, presence:true

  # attr_accessor :offer_discipline_turmas_attributes
  # attr_accessor :turmas_id
  # attr_reader :turmas_id
  # attr_writer :turmas_id

  # Usuários vinculados a disciplina devem ser professores
  # scope :teacher, -> {
  #       joins(:user).where("users.teacher is true")
  # }

  # grid_discipline, user(teacher) active

end
