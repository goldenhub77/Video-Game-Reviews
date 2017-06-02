require 'rails_helper'

RSpec.describe UserGamesController, type: :controller do

  before(:each) do
    user = FactoryGirl.create(:user)
    sign_in(user)
  end
  # 
  # describe 'index' do
  #   it 'assigns @title' do
  #     title = 'My Games'
  #     get :index
  #     expect(assigns(:title)).to eq(title)
  #   end
  #
  #   it 'assigns @video_games' do
  #     games = current_user.video_games
  #     get :index
  #     expect(assigns(:video_games)).to eq(games)
  #   end
  # end

end
