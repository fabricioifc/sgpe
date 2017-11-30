class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user

    if user.admin?
      can :manage, :all
    else

      # @perfils = user.perfils
      # @perfils.each do |perfil|
      #   if perfil.idativo?
      #     PermissaoTela.where(perfil: perfil).each do |tela|
      #       can tela.permissao.acao.to_sym, tela.permissao.classe.constantize
      #     end
      #   end
      # end

      # new e copy mesma coisa
      alias_action :new, :copy, :to => :novo
      alias_action :get_planos_aprovar, :aprovar, :reprovar, :to => :aprovar_reprovar

      user.perfils.each do |perfil|
        if perfil.idativo?
          PerfilRole.where(perfil: perfil).each do |papel|
            can papel.role.resource_id.present? ? papel.role.resource_id.to_sym : "all".to_sym, papel.role.resource_type.constantize
          end
        end
      end

      # @papeis = user.roles
      # @papeis.each do |papel|
      #   can papel.resource_id.present? ? papel.resource_id.to_sym : "all".to_sym, papel.resource_type.constantize
      # end
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
