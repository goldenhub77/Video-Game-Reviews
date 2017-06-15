require 'rails_helper'

feature 'user searches for a review', %q(
  As an authenticated user
  I want to be able to search for reviews on main
  page and on my games page
) do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:platform) { FactoryGirl.create(:platform) }
  let!(:genre) { FactoryGirl.create(:genre) }
  let!(:video_game) { FactoryGirl.create(:video_game, user_id: user.id) }

  before(:each) do
    8.times do
      FactoryGirl.create(:review, user_id: user.id, video_game: video_game)
      FactoryGirl.create(:review, user_id: user2.id, video_game: video_game)
    end
  end
# Make note - There is no route to view all available reviews. Only for a particular
# game or user
  scenario 'returns all reviews matching a search query' do
    reviews = video_game.reviews
    sign_in(user)

    visit video_game_reviews_path(video_game)

    reviews.each { |review| expect(page).to have_content(review.title) }
    expect(reviews.count).to eq(16)
    reviews = reviews.to_a
    query = reviews.pop
    fill_in 'search', with: query.title

    click_button 'Search'

    expect(page).to have_content(query.title)
    reviews.each { |review| expect(page).not_to have_content(review.title, exact: true) }
  end

  scenario 'returns no results for a particular video_game' do
    reviews = video_game.reviews
    sign_in(user)

    visit video_game_reviews_path(video_game)

    fill_in 'search', with: "no match will be found"
    visit "/video_games/#{video_game.id}/reviews?utf8=%E2%9C%93&search=#{query.title}"
    click_button 'Search'
    expect(page).to have_content("There are no results matching the term 'no match will be found'")
    reviews.each { |review| expect(page).not_to have_content(review.title, exact: true) }
  end

  scenario 'returns search results on user reviews page' do
    reviews = user.reviews
    sign_in(user)

    visit user_reviews_path(user)

    reviews.each { |review| expect(page).to have_content(review.title) }
    expect(reviews.count).to eq(8)
    reviews = reviews.to_a
    query = reviews.pop
    # fill_in 'search', with: query.title
    visit "/users/#{user.id}/reviews?utf8=%E2%9C%93&search=#{query.title}"
    # click_button 'Search'

    expect(page).to have_content(query.title)
    reviews.each { |review| expect(page).not_to have_content(review.title, exact: true) }
  end

  scenario 'returns no results on user reviews page' do
    reviews = user.reviews
    sign_in(user)

    visit user_reviews_path(user)

    fill_in 'search', with: "no match will be found"
    # http://localhost:9292/users/4/video_games?utf8=%E2%9C%93&search=test&url=%2Fusers%2F4%2Fvideo_games&page_type=video_games
    click_button 'Search'

    expect(page).to have_content("There are no results matching the term 'no match will be found'")
    reviews.each { |review| expect(page).not_to have_content(review.title, exact: true) }
  end
end
