Rails.application.routes.draw do
  resources :puntuations
  resources :replies
  resources :comments
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'contributions/new', to: 'contributions#new', as: 'contributions_new'
  get 'users/:id', to: 'sessions#show'
  get 'puntuations_new', to: 'puntuations#create'
  get 'delete_puntuation/:id', to: 'puntuations#destroy'

  resources :sessions, only: [:show, :create, :destroy]
  resources :contributions
  root 'contributions#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
