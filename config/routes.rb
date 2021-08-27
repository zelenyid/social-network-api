Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               confirmations: 'confirmations',
               passwords: 'passwords',
               registrations: 'registrations',
               sessions: 'sessions'
             }
  mount PostAPI::Post => '/'

  # Ping to ensure site is up
  resources :ping, only: [:index] do
    collection do
      get :auth
    end
  end

  namespace :api do
    namespace :v2 do
      resources :posts
    end
  end
end
