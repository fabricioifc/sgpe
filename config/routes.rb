Rails.application.routes.draw do
  resources :plan_classes
  resources :offers do
    collection do
      patch :load_grid
      # patch :load_grid_disciplines
    end
    resources :offer_disciplines do
      resources :plans
    end
  end

  resources :grid_disciplines
  resources :grids, except: [:destroy] do
    resources :grid_disciplines
  end
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
