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
  
  get 'api/v1/contributions', to: 'contributions_api#get_contributions'
  post 'api/v1/contributions', to: 'contributions_api#post_contributions'
  get 'api/v1/contributions/:id', to: 'contributions_api#show_contributions'
  get 'api/v1/comments', to: 'comments_api#get_comments'
  post 'api/v1/comments', to: 'comments_api#post_comments'
  get 'api/v1/comments/:id', to: 'comments_api#show_comments'
  get 'api/v1/replies', to: 'replies_api#get_replies'
  post 'api/v1/replies', to: 'replies_api#post_replies'
  get 'api/v1/replies/:id', to: 'replies_api#show_replies'
  get 'api/v1/users/:id', to: 'sessions_api#show_sessions'
  put 'api/v1/users/:id', to: 'sessions_api#update_sessions'
  get 'api/v1/votes', to: 'puntuations_api#get_puntuations'
  post 'api/v1/votes', to: 'puntuations_api#post_puntuations'
  delete 'api/v1/votes', to: 'puntuations_api#delete_puntuations'

  resources :sessions, only: [:show, :create, :destroy]
  resources :contributions
  root 'contributions#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
