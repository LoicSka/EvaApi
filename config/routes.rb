Rails.application.routes.draw do
  root to: 'users#index'
  namespace :api do
    namespace :v1 do
      resources :users
      resources :courses
      resources :subjects
      resources :reviews
      resources :tutor_accounts
      resources :regions
      resources :tags
      resources :user_token
      post '/login' => 'users#login', as: :login
    end
  end
end
