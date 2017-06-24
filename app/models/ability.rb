class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new

    can :manage, :all if user.admin?

    # user ||= User.new
    # if !user.perfil.nil?
    #   @permissoes = PermissaoTela.where(perfil_id: [user.perfil.id, nil])
    #
    #   @permissoes.each do |p|
    #     if p.permissao.classe == "all"
    #       can p.permissao.acao.to_sym, p.permissao.classe.to_sym
    #     else
    #       can p.permissao.acao.to_sym, p.permissao.classe.constantize
    #     end
    #   end
    # end
  end
end
