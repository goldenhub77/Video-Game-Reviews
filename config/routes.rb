Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :video_games
  resources :reviews, only: [:show, :destroy, :update]

  resources :users do
    resources :video_games
    resources :reviews
  end

  resources :video_games do
    resources :reviews
  end

  namespace :api do
    namespace :v1 do
      resources :search, only: [:index]
      # resources :video_games, only: [:index], to: 'search#all_games'
      # resources :video_games, only: [:show], to: 'search#game_page'
      # resources :user_games, only:[:index], to: 'search#user_games'
      # resources :user_reviews, only: [:index], to: 'search#user_reviews'
    end
  end

  root 'video_games#home'
end
