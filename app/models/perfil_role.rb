class PerfilRole < ApplicationRecord
  include PermissaosHelper
  belongs_to :perfil
  belongs_to :role

  validates :perfil_id, :role_id, presence:true
  validates :perfil_id, :role_id, uniqueness: {scope: [:perfil_id, :role_id]}
end
