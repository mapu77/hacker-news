Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'contributions/new', to: 'contributions#new', as: 'contributions_new'
 
  resources :sessions, only: [:create, :destroy]
  resources :contributions
  root 'contributions#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
