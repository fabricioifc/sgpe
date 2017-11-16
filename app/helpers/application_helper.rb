module ApplicationHelper

  def is_admin?
    user_signed_in? && current_user.try(:admin?)
  end

  def is_professor?
    user_signed_in? && current_user.try(:teacher?)
  end

  def avatar_navbar_image(classe = ['special-img'])
    if user_signed_in?
      if current_user.avatar.present?
        image_tag current_user.avatar.url(:icon), class: classe
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
      if current_user.avatar.present?
        image_tag(current_user.avatar.url(:thumb), class: 'img-rounded img-responsive img-thumbnail center-block').html_safe
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

end
