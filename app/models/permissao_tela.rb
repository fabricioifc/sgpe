class PermissaoTela < ApplicationRecord
  belongs_to :permissao
  belongs_to :perfil
end
