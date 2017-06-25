Rails.application.routes.draw do
  resources :cursos
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  root to: 'visitors#index'
  devise_for :users
  resources :users
end
