Rails.application.routes.draw do
  root to: 'users#index'
  namespace :api do
    namespace :v1 do
      resources :users
      resources :courses
      resources :subjects
      resources :ratings, only: [:index, :create]
      resources :reviews
      resources :bookings
      resources :tutor_accounts
      resources :regions
      resources :students
      resources :tags
      resources :user_token
      resources :password_resets, only: [:create]
      post '/login' => 'users#login', as: :login
      put '/password_resets/:password_reset_token' => 'password_resets#reset', as: :reset_password
      post '/send-welcome-email/:id' => 'users#send_welcome_email', as: :send_welcome_email
      post '/verify-email/:id' => 'users#verify_email', as: :verify_email
      get '/reviews/tutor/:id' => 'reviews#for_tutor', as: :reviews_for_tutor
      get '/bookings/tutor/:tutor_account_id' => 'bookings#index', as: :bookings_for_tutor
      get '/bookings/student/:student_id' => 'bookings#index', as: :bookings_for_student
      get '/bookings/user/:user_id' => 'bookings#index', as: :bookings_for_user
      get '/students/user/:user_id' => 'students#index', as: :students_for_user
      post '/seed' => 'users#seed', as: :seed
    end
  end
end
