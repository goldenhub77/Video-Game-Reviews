require 'rails_helper'

feature 'user votes on an existing review', %q(
  As an authenticated user
  I want to vote thumbs up or thumbs down
  for a review only once per review
) do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:platform) { FactoryGirl.create(:platform) }
  let!(:genre) { FactoryGirl.create(:genre) }
  let!(:video_game) { FactoryGirl.create(:video_game, user_id: user.id) }
  let!(:review) { FactoryGirl.create(:review, user_id: user.id, video_game_id: video_game.id )}

  scenario 'thumbs up' do
    sign_in(user)

    visit video_game_path(video_game)

    expect(page).to have_content(review.title)
    expect(page).to have_content("No ratings!")
    expect(page).to have_button("up-vote-review-#{review.id}", disabled: false)
    expect(page).to have_button("down-vote-review-#{review.id}", disabled: false)

    click_button "up-vote-review-#{review.id}"

    expect(page).to have_content("100.0")
    expect(page).to have_button("up-vote-review-#{review.id}", disabled: true)
    expect(page).to have_button("down-vote-review-#{review.id}", disabled: false)
  end

  scenario 'thumbs down' do
    sign_in(user)

    visit video_game_path(video_game)

    expect(page).to have_content(review.title)
    expect(page).to have_content("No ratings!")
    expect(page).to have_button("up-vote-review-#{review.id}", disabled: false)
    expect(page).to have_button("down-vote-review-#{review.id}", disabled: false)

    click_button "down-vote-review-#{review.id}"

    expect(page).to have_content("0")
    expect(page).to have_button("up-vote-review-#{review.id}", disabled: false)
    expect(page).to have_button("down-vote-review-#{review.id}", disabled: true)
  end
end
