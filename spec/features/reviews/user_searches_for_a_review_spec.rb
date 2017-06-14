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
# Make note - There is no route to view all available reviews only for a particular
# game or user
  scenario 'returns search results for all reviews for video_game' do
    reviews = video_game.reviews
    sign_in(user)

    visit video_game_reviews_path(video_game)

    reviews.each { |review| expect(page).to have_content(review.title) }
    expect(reviews.count).to eq(16)
    reviews = reviews.to_a
    query = reviews.pop
    fill_in 'search', with: query.title
    click_button 'Search'

    expect(page).to have_content(query.title, exact: true)
    reviews.each { |review| expect(page).not_to have_content(review.title) }
  end

  scenario 'returns no results on all game reviews page' do
    reviews = video_game.reviews
    sign_in(user)

    visit video_game_reviews_path(video_game)

    fill_in 'search', with: "no match will be found"
    click_button 'Search'

    expect(page).to have_content("There are no video reviews matching 'no match will be found'")
    reviews.each { |review| expect(page).not_to have_content(review.title) }
  end

  scenario 'returns search results on user reviews page' do
    # video_games = user.video_games
    # sign_in(user)
    #
    # visit user_games_path
    #
    # video_games.each { |game| expect(page).to have_content(game.title) }
    # expect(video_games.count).to eq(8)
    # video_games = video_games.to_a
    # query = video_games.pop
    # fill_in 'search', with: query.title
    # click_button 'Search'
    #
    # expect(page).to have_content(query.title)
    # video_games.each { |game| expect(page).not_to have_content(game.title) }
  end

  scenario 'returns no results on user reviews page' do
    # video_games = user.video_games
    # sign_in(user)
    #
    # visit video_games_path
    #
    # fill_in 'search', with: "no match will be found"
    # click_button 'Search'
    #
    # expect(page).to have_content("There are no video games matching 'no match will be found'")
    # video_games.each { |game| expect(page).not_to have_content(game.title) }
  end
end
