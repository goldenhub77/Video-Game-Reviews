require 'rails_helper'

feature 'user updates an existing review', %q(
  As an authenticated user
  I want to be able to update a review
  I created when information may change
) do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:platform) { FactoryGirl.create(:platform) }
  let!(:platform2) { FactoryGirl.create(:platform) }
  let!(:genre) { FactoryGirl.create(:genre) }
  let!(:video_game) { FactoryGirl.create(:video_game, user_id: user.id) }
  let!(:review) { FactoryGirl.create(:review, user_id: user.id, video_game_id: video_game.id )}

  scenario 'sucessfully' do

    sign_in(user)
    visit review_path(review)

    expect(page).to have_button('Edit')

    click_button 'Edit'

    expect(page).to have_content("Edit")
    expect(page).to have_content(review.title)

    fill_in 'Title', with: 'Overwatch Review'
    fill_in 'Review', with: Faker::Lorem.paragraph
    check platform2.name
    find(:xpath, "//input[@id='review_rating']").set 4

    click_button 'Update Review'

    expect(page).to have_content('You successfully updated Overwatch Review')
  end

  scenario 'fails with bad data' do

    sign_in(user)
    visit edit_user_review_path(user, review)

    fill_in 'Title', with: ''
    fill_in 'Review', with: nil

    click_button 'Update Review'

    expect(page).to have_content("3 errors in review form.")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Review can't be blank")
    expect(page).to have_content("Review is too short (minimum is 50 characters)")
  end

  scenario 'fails by no user logged in' do

    visit edit_user_review_path(user, review)

    expect(page).not_to have_button('Edit')

    visit edit_user_review_path(user, review)

    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
