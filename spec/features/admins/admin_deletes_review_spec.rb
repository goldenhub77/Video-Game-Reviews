require 'rails_helper'

feature 'admin deletes review', %q(
  As an authenticated admin
  I want to be able to delete a review
  So that a review will no longer be retained by the app
  if agreement is breached
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

    click_button "admin-delete-review-#{review.id}"

    expect(page).to have_content("You successfully deleted #{review.title}")
    expect{ Review.find(review.id) }.to raise_exception(ActiveRecord::RecordNotFound)
  end
end
