class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user

    if user.admin?
      can :manage, :all
    # elsif user.has_role? :superadmin
    #   can :manage, :all  # can manage (Read, Create, Update, Destroy, ...) everything
    # elsif user.has_role? :forum_admin
    #   # can :manage, Forum  # can manage (Read, Create, Update, Destroy, ...) any Forum
    # elsif user.has_role? :store_admin
    #   # can :manage, Store do |store|  # Can manage only its own store
    #   #   store.try(:user) == user
    #   # end
    # elsif user.has_role? :forum_member

    else # Users without role
      can :read, All
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
