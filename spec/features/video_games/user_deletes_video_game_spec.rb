require 'rails_helper'

feature 'user deletes video game', %q(
  As an authenticated user
  I want to delete my video game
  So that my video game is no longer retained by the app
) do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:platform) { FactoryGirl.create(:platform) }
  let!(:genre) { FactoryGirl.create(:genre) }
  let!(:video_game) { FactoryGirl.create(:video_game, user_id: user.id) }
  let!(:review) { FactoryGirl.create(:review, user_id: user.id, video_game_id: video_game.id) }

  scenario 'sucessfully' do
    sign_in(user)

    visit video_game_path(video_game)

    click_button 'Edit'
    save_and_open_page
    click_button 'Delete'

    expect(page).to have_content("Successfully deleted #{video_game.title}")
    expect{ VideoGame.find(video_game.id) }.to raise_exception(ActiveRecord::RecordNotFound)
    expect{ Review.find(review.id) }.to raise_exception(ActiveRecord::RecordNotFound)

  end
end
