Rails.application.routes.draw do
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :video_games
  resources :user_games, only: [:index]

  namespace :api do
    namespace :v1 do
      get 'search/video_games', to: 'search#all_games'
      get 'search/user_games', to: 'search#user_games'
    end
  end

  root 'video_games#home'
end
