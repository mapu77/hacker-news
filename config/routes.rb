Rails.application.routes.draw do
  resources :reply_puntuations
  resources :comment_puntuations
  resources :puntuations
  resources :replies
  resources :comments
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'contributions/new', to: 'contributions#new', as: 'contributions_new'
  get 'users/:id', to: 'sessions#show'
  post 'users/:id', to: 'sessions#update'
  get 'puntuations_new', to: 'puntuations#create'
  get 'delete_puntuation/:id', to: 'puntuations#destroy'
  get 'puntuations_new_comment', to: 'comment_puntuations#create'
  get 'delete_puntuation_comment/:id', to: 'comment_puntuations#destroy'
  get 'puntuations_new_reply', to: 'reply_puntuations#create'
  get 'delete_puntuation_reply/:id', to: 'reply_puntuations#destroy'
  get 'contributions/puntuations_new', to: 'puntuations#create'
  get 'contributions/delete_puntuation/:id', to: 'puntuations#destroy'
  get 'contributions/reply/new/:coment', to: 'replies#new'
  get 'users/:id/comments', to: 'comments#index'

  resources :sessions, only: [:show, :create, :destroy]
  resources :contributions
  root 'contributions#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
