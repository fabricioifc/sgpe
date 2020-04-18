module ApplicationHelper

  def is_admin?
    user_signed_in? && current_user.try(:admin?)
  end

  def is_professor?
    user_signed_in? && (current_user.try(:teacher?) || current_user.perfils.pluck('UPPER(name)').include?('PROFESSOR') )
  end

  def is_professor_discipline? professor
    user_signed_in? && current_user.try(:teacher?) && current_user.eql?(professor)
  end

  def avatar_navbar_image(classe = ['special-img'])
    if user_signed_in?
      if current_user.avatar.attached?
        image_tag current_user.avatar.variant(resize: '40x40'), class: classe
      else
        self.gravatar_url(current_user.email, 36, classe)
      end
    end
  end

  def gravatar_url(email, size, classe)
    gravatar_id = Digest::MD5::hexdigest(email).downcase
    default_url = "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Logotipo_IFET.svg/764px-Logotipo_IFET.svg.png"
    url = "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=#{CGI::escape(default_url)}"
    image_tag url, height: size, class: classe
  end

  def show_profile_image
    if user_signed_in?
      if current_user.avatar.attached?
        image_tag(current_user.avatar, class: 'img-rounded img-responsive img-thumbnail center-block').html_safe
      end
    end
  end

  def titulo_painel(model)
    t '.title', :default => model.model_name.human.pluralize.titleize
  end

  def link_to_new(model, path)
    link_to path do
      text = content_tag :i, nil, class: 'fa fa-plus'
      text << ' ' << t('.new', :default => t("helpers.titles.new", model: model))
      text
    end
  end

  def get_planos_disciplina offer_discipline_id
    Plan.where(offer_discipline_id: offer_discipline_id, active:true).order(versao: :desc)
  end

  def get_planos_disciplina_aprovados offer_discipline_id
    Plan.where(offer_discipline_id: offer_discipline_id, active:true, aprovado:true).order(versao: :desc)
  end

  def get_planos_disciplina_reprovados offer_discipline_id
    Plan.where(offer_discipline_id: offer_discipline_id, active:true, reprovado:true).order(versao: :desc)
  end

  def get_planos_disciplina_analise offer_discipline_id
    Plan.where(offer_discipline_id: offer_discipline_id, active:true, analise:true).order(versao: :desc)
  end

  def dropdown_autorizacao *models
    autorizado = false
    models.each do |m|
      if can? :read, m
        autorizado = true
        break
      end
    end
    autorizado
  end

end
