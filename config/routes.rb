Rails.application.routes.draw do
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :video_games
  resources :users do
    resources :video_games, controller: :user_games, only: [:index]
  end

  root 'video_games#home'
end
