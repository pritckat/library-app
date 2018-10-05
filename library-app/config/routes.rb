Rails.application.routes.draw do
  resources :authors
  resources :books
  resources :libraries
  resources :users
  
  get '/login' => "sessions#new"
  post '/login' => "sessions#create"
  delete '/logout' => "sessions#destroy"

  resources :libraries do
    resources :books, only: [:new, :create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
