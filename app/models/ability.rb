class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user

    if user.admin?
      can :manage, :all
    else

      @perfils = user.perfils
      @perfils.each do |perfil|
        if perfil.idativo?
          PermissaoTela.where(perfil: perfil).each do |tela|
            can tela.permissao.acao.to_sym, tela.permissao.classe.constantize
          end
        end
      end
    end

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
