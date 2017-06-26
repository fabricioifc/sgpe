module VisitorsHelper

  def show_profile_image
    if user_signed_in?
      if current_user.avatar.present?
        image_tag(current_user.avatar.url(:thumb), class: 'img-rounded img-responsive img-thumbnail center-block').html_safe
      end
    end
  end

end
