Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :labels
  end
  root "tasks#index"
  resources :users, only: [:new, :create, :show]
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :tasks
  # resources :labels
end
