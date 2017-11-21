Rails.application.routes.draw do
  resources :offers do
    collection do
      patch :load_grid
      # get '/course_plans/:user_id', to: 'plans#course_plans'
      # patch :load_grid_disciplines
    end
    resources :offer_disciplines do
      resources :plans do
        member do
          get 'copy'
        end
      end
    end
  end

  get 'course_plans/:course_id', to: 'plans#course_plans', as: 'plans_by_course'

  resources :grid_disciplines
  resources :grids, except: [:destroy] do
    member do
      get 'escolher'
    end
    resources :grid_disciplines
  end
  resources :turmas
  resources :course_offers
  resources :courses
  resources :course_modalities
  resources :course_formats
  resources :disciplines, path: 'disciplinas'
  resources :permissao_telas
  resources :permissaos
  resources :perfils
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root to: 'visitors#index'
  devise_for :users
  resources :users
end
