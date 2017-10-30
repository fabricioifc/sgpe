source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.1'
# gem 'rails', '~> 5.1.3'

gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
# gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'bootstrap-sass'
gem 'devise'
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
gem 'bootswatch-rails'
gem 'carrierwave'
gem 'mini_magick'; #precisa do RMagick instalado
gem 'cloudinary'
gem 'rails_admin', '~> 1.2' # Painel de administração do sistema
gem 'rails_admin-i18n' # Painel de administração do sistema
gem 'rails_admin_rollincode', '~> 1.0' # Painel de administração do sistema
gem 'cancancan', '~> 2.0'# controle de permissões
gem "rolify" # controle de papéis
gem "select2-rails"
gem 'bootstrap_form'
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
  gem 'better_errors'
  gem 'foreman'
  gem 'pry-rails'
  # gem 'guard-bundler'
  # gem 'guard-rails'
  # gem 'guard-rspec'
  # gem 'rails_layout'
  # gem 'rb-fchange', :require=>false
  # gem 'rb-fsevent', :require=>false
  # gem 'rb-inotify', :require=>false
  # gem 'spring-commands-rspec'
  # gem 'mailcatcher'
  # gem 'shoulda-matchers'
  # gem 'cucumber-rails', require: false
  # gem 'coveralls', require: false
  # gem 'factory_girl_rails'
  # gem 'faker'
  # gem 'pry-rescue'
  # gem 'pry-byebug'
  # gem 'rspec-rails'
  # gem 'rubocop'
  # gem 'database_cleaner'
  # gem 'launchy'
end
# Notificar admin caso ocorra algum erro na aplicação
gem 'exception_notification'
gem 'slack-notifier'
gem 'sidekiq'
gem "letter_opener"
gem 'sinatra', '>= 1.3.0', :require => nil
gem 'redis-rails'
gem 'tinymce-rails' #html editor
gem 'tinymce-rails-langs'

gem 'cocoon'
gem 'summernote-rails'
gem 'page_title_helper'
gem 'amoeba' # para duplicar registros e seus filhos
gem 'wicked'
