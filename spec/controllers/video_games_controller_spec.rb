require 'rails_helper'

RSpec.describe VideoGamesController, type: :controller do

  before(:each) do
    user = FactoryGirl.create(:user)
    sign_in(user)
  end

  describe 'index' do
    it 'initializes @title' do
      title = 'Available Games'
      get :index
      expect(assigns(:title)).to eq(title)
    end
  end
end
