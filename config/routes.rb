Rails.application.routes.draw do
  resources :grids
  resources :turmas
  resources :course_offers
  resources :courses
  resources :course_modalities
  resources :course_formats
  resources :tests
  resources :disciplines, path: 'disciplinas'
  resources :posts
  resources :permissao_telas
  resources :permissaos
  resources :perfils
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root to: 'visitors#index'
  devise_for :users
  resources :users
end
