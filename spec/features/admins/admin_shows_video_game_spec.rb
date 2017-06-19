require 'rails_helper'

feature 'admin shows user video game', %q(
  As an authenticated admin
  I want to be able to show a user video game
  So that a user video game will display its show page from the admins page
) do

  let!(:admin) { FactoryGirl.create(:user, role: 'admin') }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:platform) { FactoryGirl.create(:platform) }
  let!(:genre) { FactoryGirl.create(:genre) }
  let!(:video_game) { FactoryGirl.create(:video_game, user_id: user.id) }
  let!(:review) { FactoryGirl.create(:review, user_id: user.id, video_game_id: video_game.id) }

  scenario 'sucessfully' do
    sign_in(admin)

    visit admins_path

    click_button "admin-show-video-game-#{video_game.id}"

    expect(page).to have_content(video_game.title)
    expect(page).to have_content(review.title)
  end
end
