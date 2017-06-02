require 'rails_helper'

RSpec.describe VideoGamesController, type: :controller do

  before(:each) do
    user = FactoryGirl.create(:user)
    sign_in(user)
  end
  
  describe '.load_games' do
    it 'intializes @video_games' do
      video_games = VideoGame.all
      controller = VideoGamesController.new()
      loaded_games = controller.instance_eval{ load_games }
      expect(loaded_games).to eq(video_games)
    end
  end

  describe 'index' do
    it 'initializes @title' do
      title = 'Available Games'
      get :index
      expect(assigns(:title)).to eq(title)
    end
  end
end
