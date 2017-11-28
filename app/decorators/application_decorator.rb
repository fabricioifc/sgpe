class ApplicationDecorator < Draper::Decorator

  # Define methods for all decorated objects.
  # Helpers are accessed through `helpers` (aka `h`). For example:
  #
  #   def percent_amount
  #     h.number_to_percentage object.amount, precision: 2
  #   end

  def active_tag(campo, klass = [])
    if campo
      h.content_tag :i, nil, class: "fa fa-check-square #{klass}"
    else
      h.content_tag :i, nil, class: "fa fa-square-o #{klass}"
    end
  end

  def link_show
    h.link_to "<i class='fa fa-list fa-2'></i>".html_safe, component
  end

  def link_edit
    h.link_to "<i class='fa fa-pencil-square-o fa-2'></i>".html_safe, [:edit, component]
  end

  def link_destroy
    h.link_to("<i class='fa fa-trash-o fa-2'></i>".html_safe, component, method: :delete, data: { confirm: 'Tem certeza?' })
  end

  def get_class_name
    component.class.name.singularize.downcase
  end

  def converter_para_html componente, pdf = false
    unless componente.nil?
      if pdf
        whitelist = ['b', 'i', 'u', 'strikethrough', 'sub', 'sup', 'font', 'color', 'link', 'p', 'li', 'ul']
        ActionController::Base.helpers.sanitize(componente, :tags => whitelist).
          gsub(/<p[^>]*>/, '').split("</p>").map { |x|
            "#{x.strip}\r\n"
          }.join.
          gsub(/<li[^>]*>/, '•  ').split("</li>").map { |x|
            "#{x.strip}\r\n"
          }.join.
          gsub(/<ul[^>]*>/, '').split(/<\/ul[^>]*>/).map { |x|
            "#{x.strip}\n\r\n"
          }.join
      else
        ActionController::Base.helpers.sanitize(componente)
      end
    end
  end
end
