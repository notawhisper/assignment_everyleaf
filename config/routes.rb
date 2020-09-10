Rails.application.routes.draw do
  root "tasks#index"

  namespace :admin do
    resources :users
    resources :labels
  end
  resources :users, only: [:new, :create, :show]
  resources :tasks
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
