class Admins::UsersController < ApplicationController
  before_action :get_user, only: [:show, :destroy]

  def index
  end

  def show

  end

  def destroy
    if @user.destroy
      flash[:notice] = "You successfully deleted #{@user.full_name}"
    else
      flash[:notice] = "Failed to remove #{@user.full_name}"
    end
    redirect_to admins_path
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
