Rails.application.routes.draw do
  
  authenticated :user do
    get 'homepage', to: "homepage#show"
    get  "homepage_edit", to: "homepage#edit_user"
  end
  get 'home/index'
  root "home#index"
  resources :posts
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        omniauth_callbacks: "users/omniauth_callbacks"
      }


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

 
  
  namespace :api do
    resources :users, only: :show
    get "users_by_emails", to: "users_by_emails#show"
  end

  devise_scope :user do
    get "update", to: "users/edit_user#update"
    get "sign_in", to: "users/log_in#login"
    post "sign_up", to: "users/sign_up#signup"
  end
end
