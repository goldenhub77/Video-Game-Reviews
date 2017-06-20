require 'rails_helper'

feature 'user creates a new review', %q(
  As an authenticated user
  I want to create a review
  for a video game
) do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:platform) { FactoryGirl.create(:platform) }
  let!(:genre) { FactoryGirl.create(:genre) }
  let!(:video_game) { FactoryGirl.create(:video_game, user_id: user.id) }

  scenario 'sucessfully' do

    sign_in(user)

    visit video_game_path(video_game)

    expect(page).to have_button('Write a review..')

    click_button 'Write a review...'

    fill_in 'Title', with: 'Test review for a video game'
    fill_in 'Review', with: Faker::Lorem.paragraph
    check platform.name

    click_button 'Create Review'

    expect(page).to have_content('Successfully created Test review for a video game')
  end

  scenario 'fails with bad data' do
    sign_in(user)

    visit video_game_path(video_game)

    expect(page).to have_button('Write a review...')

    click_button 'Write a review...'
    click_button 'Create Review'

    expect(page).to have_content('4 errors in review form.')
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Review can't be blank")
    expect(page).to have_content('Review is too short (minimum is 50 characters)')
    expect(page).to have_content("Platforms can't be blank")
  end

  scenario 'fails by no user logged in' do

    visit new_video_game_review_path(video_game)

    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
