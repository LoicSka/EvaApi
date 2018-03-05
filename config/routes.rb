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
      resources :user_token
    end
  end
end
