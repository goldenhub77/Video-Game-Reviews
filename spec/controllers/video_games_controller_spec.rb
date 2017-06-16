require 'rails_helper'

RSpec.describe VideoGamesController, type: :controller do

  before(:each) do
    user = FactoryGirl.create(:user)
    sign_in(user)
  end

  
end
