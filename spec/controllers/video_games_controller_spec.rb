require 'rails_helper'

RSpec.describe VideoGamesController, type: :controller do

  before(:each) do
    user = FactoryGirl.create(:user)
    sign_in(user)
  end

  describe '.load_games' do
    it 'intializes @all_video_games' do
      all_video_games = VideoGame.order('created_at DESC')
      controller = VideoGamesController.new()
      load_games = controller.instance_eval{ load_games }
      expect(load_games).to eq(all_video_games)
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
