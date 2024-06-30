Rails.application.routes.draw do
  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
  end

  authenticated :user do
    get 'homepage', to: "homepage#show"
    get  "homepage_edit", to: "homepage#edit_user"
    get "mycards", to: "posts#mycards"
  end
  get 'home/index'
  root "home#index"
  resources :posts
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        omniauth_callbacks: "users/omniauth_callbacks"
      }



  get "up" => "rails/health#show", as: :rails_health_check



  devise_scope :user do
    patch "update", to: "users/edit_user#update"
    get "sign_in", to: "users/log_in#login"
    post "sign_up", to: "users/sign_up#signup"
  end

  
  resources :posts do
    resources :messages, only: [:create]
  end

  

end
