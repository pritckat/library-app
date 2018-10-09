Rails.application.routes.draw do
  root "welcome#show"
  
  resources :authors
  resources :books
  resources :libraries
  resources :users
  
  get '/login' => "sessions#new"
  post '/login' => "sessions#create"
  delete '/logout' => "sessions#destroy"

  get '/books/:id/loan' => "books#loan"
  patch '/books/:id/loaned' => "books#loaned", as: "loan"

  resources :libraries do
    resources :books, only: [:new, :create]
  end

  resources :users do
    resources :books, only: [:index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
