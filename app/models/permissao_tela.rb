class PermissaoTela < ApplicationRecord
  belongs_to :permissao
  belongs_to :perfil

  validates :permissao_id, :perfil_id, :presence => true, uniqueness: {scope: [:permissao_id, :perfil_id]}
end
