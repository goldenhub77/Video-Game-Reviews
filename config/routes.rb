Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :video_games
  resources :user_games, only: [:index]
  #this resource may not be needed, will assess later
  # resources :reviews, only: [:new, :edit, :create, :update]

  resources :video_games do
    resources :reviews
  end

  namespace :api do
    namespace :v1 do
      get 'search/video_games', to: 'search#all_games'
      get 'search/user_games', to: 'search#user_games'
      get 'search/reviews', to: 'search#reviews'
    end
  end

  root 'video_games#home'
end
