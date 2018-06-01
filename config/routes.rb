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
      resources :students
      resources :tags
      resources :user_token
      post '/login' => 'users#login', as: :login
      post '/send-welcome-email/:id' => 'users#send_welcome_email', as: :send_welcome_email
      post '/verify-email/:id' => 'users#verify_email', as: :verify_email
      get '/reviews/tutor/:id' => 'reviews#for_tutor', as: :reviews_for_tutor
    end
  end
end
