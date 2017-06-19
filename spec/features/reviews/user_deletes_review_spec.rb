require 'rails_helper'

feature 'user deletes review', %q(
  As an authenticated user
  I want to delete my review
  So that my review is no longer retained by the app
) do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:platform) { FactoryGirl.create(:platform) }
  let!(:genre) { FactoryGirl.create(:genre) }
  let!(:video_game) { FactoryGirl.create(:video_game, user_id: user.id) }
  let!(:review) { FactoryGirl.create(:review, user_id: user.id, video_game_id: video_game.id) }

  scenario 'sucessfully' do
    sign_in(user)

    visit review_path(review)

    click_button 'Edit'

    click_button 'Delete'

    expect(page).to have_content("You successfully deleted #{review.title}")
    expect{ Review.find(review.id) }.to raise_exception(ActiveRecord::RecordNotFound)
    
  end
end
