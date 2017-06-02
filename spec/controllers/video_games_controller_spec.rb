require 'rails_helper'

RSpec.describe VideoGamesController, type: :controller do
  describe 'before all actions' do
    it 'loads @video_games' do
      user = FactoryGirl.create(:user)
      sign_in(user)
      video_games = VideoGame.all
      get :index
      expect(assigns(:video_games)).to eq(video_games)
    end
  end
end
