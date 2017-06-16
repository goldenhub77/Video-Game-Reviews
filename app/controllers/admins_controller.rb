class AdminsController < ApplicationController

  def index
    @all_users = User.all
    @all_video_games = VideoGame.all
    @all_reviews = Review.all
  end
end
