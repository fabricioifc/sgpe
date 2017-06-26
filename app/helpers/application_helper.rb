module ApplicationHelper

  def is_admin?
    user_signed_in? && current_user.try(:admin?)
  end

  # def gravatar_url(email, size)
  #   gravatar_id = Digest::MD5::hexdigest(email).downcase
  #   default_url = "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Logotipo_IFET.svg/764px-Logotipo_IFET.svg.png"
  #   url = "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=#{CGI::escape(default_url)}"
  # end
end
