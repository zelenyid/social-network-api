Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               confirmations: 'confirmations',
               passwords: 'passwords',
               registrations: 'registrations',
               sessions: 'sessions'
             }
  mount SocialNetwork::Base => '/'

  # namespace :api do
  #   namespace :v2 do
  #     resources :posts
  #   end
  # end
end
