class Curso < ApplicationRecord
  belongs_to :user

  validates :title, :sigla, :description, presence:true
end
