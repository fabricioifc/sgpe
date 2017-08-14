set :application_name, 'sgpe'
set :domain, "200.135.61.15"
set :deploy_to, "/home/deploy/sgpe_production"
set :repository, "git@bitbucket.org:fraiburgoifc/planodeensinoifc.git"
set :branch, "master"
set :port, '50235'

set :user, "deploy"
set :forward_agent, true
set :rails_env, 'production'
