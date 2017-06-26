class Perfil < ApplicationRecord
  has_and_belongs_to_many :role, :join_table => :perfil_roles
end
