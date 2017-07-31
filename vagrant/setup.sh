#!/usr/bin/env bash

# instalar este pacote na máquina local
# sudo apt-get install nfs-kernel-server

# instalar nfs para compartilhamento de arquivos
sudo apt-get install nfs-common portmap

# install javascript runtime, which is required by gem `uglifier`
sudo apt-get install -y nodejs nodejs-legacy npm git

# git config --global user.name $2
# git config --global user.email $3

# install postgresql
sudo apt-get install -y postgresql postgresql-contrib postgresql-client libpq-dev
# create superuser using current linux user
sudo -u postgres createuser -s -e 'ubuntu'
# Alterar a senha
sudo -u postgres psql -c "alter user ubuntu with password 'postgres';"
sudo -u postgres psql -c "alter user postgres with password 'postgres';"

# gem install
cd /vagrant
gem install bundler --no-ri --no-rdoc

# to check whether Rails has been initialised
# if no, create a Rails project using the folder basename ($1), which is mounted to /vagrant in VM
if [ ! -f Gemfile ]; then
  gem install rails --no-ri --no-rdoc
  rails new $1 --skip-bundle --no-skip-git --database=postgresql
  mv $1/* .
  rm -r $1
fi

# all setup in README file could go here
bundle install

bundle exec rake db:exists && rake db:migrate || rake db:create db:migrate db:seed
