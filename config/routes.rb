Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "profil", to: "pages#profil"
  resources :trip_sessions, only: %i[show create new] do
    member do
      patch :join
      patch :leave
      get :waiting_room
    end

    resources :requests, only: :create
  end

  resources :requests, only: :show do
    member do
      patch :accept
      patch :decline
    end
  end

  resources :game_matches, only: :show do
    resources :messages, only: :create
    member do
      get :counter
    end
  end


  resources :tic_tac_toe_games, only: :show do
    member do
      patch :select_tile
    end
  end
end
