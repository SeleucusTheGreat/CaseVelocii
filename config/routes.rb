Rails.application.routes.draw do

  authenticated :user, ->(user) { user.admin?} do
    namespace :admin do
      get 'dashboard', to: 'dashboard#index'
    end
  end
  
  authenticated :user do
    get 'notifications/:id', to: 'notifications#mark_and_redirect', as: 'mark_and_redirect_notification'
    get 'userpage', to: "userpage#show"
    get "userpage_edit", to: "userpage#edit_user"
    get "mycards", to: "posts#mycards"
  end
  get 'home/index'
  root "home#index"
  

  devise_for :users, skip: [:passwords, :confirmations, :unlocks, :sessions, :registrations],  controllers: {
        omniauth_callbacks: "users/omniauth_callbacks"
      }


  devise_scope :user do
    patch "update", to: "users/edit_user#update"
    get "sign_in_modal", to: "users/log_in#login"
    post "sign_up_modal", to: "users/sign_up#signup"
    get "sign_in", to: "users/sessions#new", as: :new_user_session
    post "sign_in", to: "users/sessions#create", as: :user_session
    delete "sign_out", to: "users/sessions#destroy", as: :destroy_user_session
    get "sign_up", to: "users/registrations#new", as: :new_user_registration
    post "sign_up", to: "users/registrations#create", as: :user_registration
  end

  

  concern :chattable do
    resources :chats, only: [:show] do
      resources :messages, only: [:create]
    end
  end

  resources :posts, concerns: :chattable
  resources :chats, only: [:index]

  get "up" => "rails/health#show", as: :rails_health_check

end
