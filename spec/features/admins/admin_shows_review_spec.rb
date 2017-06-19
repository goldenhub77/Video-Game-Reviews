require 'rails_helper'

feature 'admin shows user review', %q(
  As an authenticated admin
  I want to be able to show a user review
  So that a user review will display its show page from the admins page
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

    click_button "admin-show-review-#{review.id}"

    expect(page).to have_content(review.title)
    expect(page).to have_content(review.review)
    expect(page).to have_content(video_game.title)

  end
end
