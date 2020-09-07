Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end
  root "tasks#index"
  resources :users
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :tasks
end
