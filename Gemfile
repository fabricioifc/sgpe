source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.1'
# gem 'rails', '~> 5.1.3'

gem 'yard', '~> 0.9.12'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
# gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'bootstrap-sass', '~> 3.3.7'
gem 'bootstrap-modal-rails', '~> 2.2.5'
gem 'bootstrap-multiselect-rails', '~> 0.9.9'
gem 'devise'
gem 'devise_invitable', '~> 1.7.0'
# gem "devise-async", :group => [:production, :staging]
gem "devise-async", :group => [:production]
gem 'devise-i18n'
gem 'high_voltage'
gem 'jquery-rails'
gem 'pg'

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Adicionadas depois
gem 'bootswatch-rails', '~> 3.3.5'
gem 'carrierwave'
gem 'mini_magick'; #precisa do RMagick instalado
gem 'cloudinary'
gem 'rails_admin', '~> 1.3' # Painel de administração do sistema
gem 'rails_admin-i18n' # Painel de administração do sistema
gem 'rails_admin_rollincode', '~> 1.0' # Painel de administração do sistema
gem 'cancancan', '~> 2.0'# controle de permissões
gem "rolify" # controle de papéis
gem "select2-rails"
# gem 'chosen-rails'
gem 'multi-select-rails'
gem 'bootstrap_form', '~> 2.7.0'
gem 'font-awesome-sass', '~> 4.7.0'
# gem 'bootstrap-generators', '~> 3.3.4'
# gem 'will_paginate', '~> 3.1', '>= 3.1.6'
# gem 'will_paginate-bootstrap', '~> 1.0', '>= 1.0.1'
gem 'rails-assets-jquery', source: 'https://rails-assets.org'
gem 'rails-assets-datatables', source: 'https://rails-assets.org'
gem 'kaminari' #paginação

gem 'record_tag_helper', '~> 1.0' #permite usar content_for_tag
gem 'draper', '~> 3.0' #padrão decorator
#Gerador de PDF
gem 'prawn', '~> 2.2', '>= 2.2.2'
gem 'prawn-rails', '~> 1.0', '>= 1.0.1'
gem 'prawn-table', '~> 0.2.2'
###############################################################################
#Deploy application
gem 'mina', require: false
gem 'mina-puma', require: false#,  github: 'untitledkingdom/mina-puma'
gem 'mina-whenever', require: false
gem 'mina-sidekiq', require: false
# gem 'mina-multistage', require: false
gem 'dotenv-rails'
###############################################################################
#BACKUP DATABASE automatizado
# gem 'pg_backup', '~> 0.0.3'
gem 'whenever', '~> 0.9.4'
###############################################################################
gem 'turnout'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'better_errors', '~> 2.4.0'
  gem 'foreman'
  gem 'pry-rails'
  gem 'faker'
end
# Notificar admin caso ocorra algum erro na aplicação
gem 'exception_notification'
gem 'slack-notifier'
gem 'sidekiq', '~> 5.1.3', group: :production
group :development, :staging do
  gem 'letter_opener_web', '~> 1.0'
end
gem 'sinatra', '>= 2.0.1', :require => nil
gem 'redis-rails'
gem 'tinymce-rails' #html editor
gem 'tinymce-rails-langs'

gem 'cocoon'
gem 'summernote-rails'
gem 'page_title_helper'
gem 'amoeba' # para duplicar registros e seus filhos
gem "breadcrumbs_on_rails", '~> 3.0.1' # breadcrumb
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
gem 'roo' # Importar arquivos CSV
# gem 'simple_form'
# gem 'effective_form_inputs'
gem 'date_validator'

# Email template custom
gem 'nokogiri', '~> 1.8.2'
gem 'premailer-rails'
