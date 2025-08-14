Rails.application.routes.draw do
  root "gossips#index"

  resources :gossips do
    resources :comments, only: [:create]  # AJOUT : route imbriquée pour créer un commentaire d’un gossip
     resources :likes,    only: [:create, :destroy]
  end

  resources :cities, only: [:index, :show]
  resources :users,  only: [:new, :create]
 

  resources :sessions, only: [:new, :create, :destroy]
  get    "/login",  to: "sessions#new"
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "up" => "rails/health#show", as: :rails_health_check
end
