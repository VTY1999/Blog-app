Rails.application.routes.draw do
  
  root "users#index"
   post '/api/v1/auth/login', to: 'authentication#login'
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :users, only: [:show, :create] do
        resources :posts, only: [:index] do
          resources :comments, only: [:index, :create]
        end
      end
    end
  end

  devise_for :users,
   path: '',
   path_names: {
     sign_in: 'login',
     sign_out: 'logout',
     password: 'secret',
     confirmation: 'verification',
     registration: 'register',
     sign_up: 'signup'
   }

 resources :users, only: [:index, :show] do
   resources :posts, only: [:index, :show, :new, :create, :destroy] do
     resources :comments, only: [:new, :create, :destroy]
     resources :likes, only: [:new, :create]
   end
 end
end
