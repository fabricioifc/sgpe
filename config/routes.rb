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
          post 'aprovar'
        end
      end
    end
  end

  get 'planos/:course_id', to: 'plans#planos_curso', as: 'planos_curso'
  get 'planos', to: 'plans#planos_professor', as: 'planos_professor'
  # put 'update_perfils/:users', to: 'user#update_perfils', as: 'update_perfils_users'
  get 'aprovacao', to: 'plans#get_planos_aprovar', as: 'get_planos_aprovar'
  # put 'aprovacao/:plan', to: 'plans#aprovar', as: 'aprovar_plano'

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
  resources :users do
    collection do
      put 'update_perfils'
    end
  end
end
