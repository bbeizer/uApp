Rails.application.routes.draw do
  get 'users/new'
  get 'sessions/new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'static_pages#home'
  get '/help',    to: 'static_pages#help', as: :help
  get '/about',    to: 'static_pages#help', as: :about
  get 'signup' => 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :account_activations, only: [:edit]
  resources :users

end
