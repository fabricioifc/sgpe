module ApplicationHelper

  def is_admin?
    user_signed_in? && current_user.try(:admin?)
  end

  def avatar_navbar_image
    if user_signed_in?
      if current_user.avatar.present?
        image_tag current_user.avatar.url(:icon), class: 'img-rounded special-img'
      else
        self.gravatar_url(current_user.email, 36, 'special-img')
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
  
end
