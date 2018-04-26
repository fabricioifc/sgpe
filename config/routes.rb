require 'sidekiq/web'

Rails.application.routes.draw do

  resources :coordenadors, path: :coordenadores
  resources :offers do
    collection do
      patch :load_grid
      # get '/course_plans/:user_id', to: 'plans#course_plans'
      # patch :load_grid_disciplines
    end
    member do
      post :gerar_planos_lote
    end
    resources :offer_disciplines do
      resources :plans do
        member do
          get 'copy'
          get 'copy_outra_oferta'
          post 'aprovar'
          get 'enviar_aviso_nupe'
        end
      end
    end
  end

  get "planos/:id/parecer" => 'plans#plano_parecer', :as => :plano_parecer
  get 'planos/:course_id', to: 'plans#planos_curso', as: 'planos_curso'
  get 'planos', to: 'plans#planos_professor', as: 'planos_professor'
  # put 'update_perfils/:users', to: 'user#update_perfils', as: 'update_perfils_users'
  get 'aprovacao', to: 'plans#get_planos_aprovar', as: 'get_planos_aprovar'
  # get 'aprovacao_user', to: 'plans#get_planos_user_aprovar', as: 'get_planos_user_aprovar'
  # put 'aprovacao/:plan', to: 'plans#aprovar', as: 'aprovar_plano'

  # Área pública para planos
  get 'plans/public/index', to: 'plans#public_index', as: 'public_index'
  post 'plans/public/index', to: 'plans#public_index_course', as: 'public_index_course'

  get 'plans/public/:course_id/disciplinas', to: 'plans#public_disciplinas', as: 'public_disciplinas'
  post 'plans/public/:course_id/disciplinas', to: 'plans#public_disciplina_planos', as: 'public_disciplina_planos'

  get 'plans/public/:course_id/:discipline_id/planos', to: 'plans#public_curso_disciplina_planos', as: 'public_curso_disciplina_planos'
  # post 'plans/public/:course_id/:discipline_id/planos', to: 'plans#public_curso_disciplina_planos', as: 'public_curso_disciplina_planos'

  get 'plans/publico/index', to: 'plans#publico_index', as: 'publico_index'
  post 'plans/publico/index', to: 'plans#publico_index_planos', as: 'publico_index_planos'
  get 'plans/admin/enviar_aviso_nupe', to: 'plans#enviar_aviso_nupe', as: 'admin_enviar_aviso_nupe'
  match '/pesquisar' => 'plans#pesquisar', as: 'pesquisar_planos', via: [:get, :post]

  # Coordenação de curso
  match '/ofertas_coordenador' => 'offers#pesquisar', as: 'ofertas_coordenador', via: [:get, :post]
  match '/ofertas_coordenador/enviar_aviso_plano_pendente' => 'offers#enviar_aviso_plano_pendente', as: 'coor_enviar_aviso_plano_pendente', via: [:get]
  match '/ofertas_coordenador/enviar_aviso_planos_pendentes' => 'offers#enviar_aviso_plano_pendente', as: 'coor_enviar_aviso_planos_pendentes', via: [:get]

  resources :grid_disciplines
  resources :grids, except: [:destroy] do
    member do
      get 'copy'
    end
    collection do
      get :importar
      post  :importar
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
  resources :roles
  resources :perfil_roles, except: [:show]

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # Configurar para que a tela inicial seja a tela de login, caso não esteja autenticado
  devise_for :users, skip: [:sessions]
    as :user do
      get 'login', to: 'devise/sessions#new', as: :new_user_session
      post 'login', to: 'devise/sessions#create', as: :user_session
      match 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session, via: Devise.mappings[:user].sign_out_via
  end
  unauthenticated do
    as :user do
      root to: 'devise/sessions#new'
    end
  end

  resources :users do
    collection do
      put 'update_perfils'
    end
  end

  # Interface para acessar as tarefas em background através do sidekiq
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq' if Rails.env.production? || Rails.env.staging?
  end

  # endereço para ver os e-mails no ambiente de aprovação (staging)
  # mount LetterOpenerWeb::Engine, at: "/mails" if Rails.env.staging? || Rails.env.development?

  root to: 'visitors#index'

end
