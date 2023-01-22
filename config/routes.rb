Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "home/index"
  root to: "home#index"

  devise_scope :user do
    get "logout" => "devise/sessions#destroy", :as => "logout"
    resources :game_copies
    resources :rentals do
      member do
        put :set_swapped
        put :set_finished
        put :set_problem
        put :accept
      end
    end

    resources :user_opinions
    resources :game_copy_opinions
    resources :game_opinions

    resources :rental_requests do
      member do
        put :submit
        put :reopen
        put :remove_offered
        put :remove_wanted
      end
    end
    resources :wanted_per_requests, only: [:create, :destroy]
    resources :offered_per_requests, only: [:create, :destroy]
    resources :users do
      member do
        put :star
      end
    end
  end

  resources :games
end
