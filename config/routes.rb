Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "home/index"
  root to: "home#index"

  devise_scope :user do
    get "logout" => "devise/sessions#destroy", :as => "logout"
  end

  resources :users
  resources :games
  resources :game_copies
  resources :rental_requests
end
