Rails.application.routes.draw do
  resources :users
  root 'controller_name#hello'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
