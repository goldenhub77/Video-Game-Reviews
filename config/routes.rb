Rails.application.routes.draw do
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root to be implemented after devise user feature completed
  # root 'video_games_path'
  root 'video_games#index'
end
