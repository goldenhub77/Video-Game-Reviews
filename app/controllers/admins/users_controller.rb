class Admins::UsersController < ApplicationController
  before_action :get_user, only: [:show, :destroy]

  def index
  end

  def show

  end

  def destroy
    @user.destroy
  end

  protected

  def get_user
    @user = User.find(get_review_params[:id])
  end

  def get_review_params
    params.permit(:id, :search, :user_id, :video_game_id, :review_search)
  end

  def post_review_params
    ReviewDecanter.decant(params[:review])
  end
end
