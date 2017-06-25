# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
#   html_tag.html_safe
# end
ActionView::Base.field_error_proc = Proc.new { |html_tag, instance|
  "<div class=\"field_with_errors control-group has-error\">#{html_tag}</div>".html_safe
}
