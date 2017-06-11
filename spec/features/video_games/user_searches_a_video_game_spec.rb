require 'rails_helper'

feature 'user searches a video game', %q(
  As an authenticated user
  I want to be able to search for games on main
  page and on my games page
) do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:platform) { FactoryGirl.create(:platform) }
  let!(:genre) { FactoryGirl.create(:genre) }

  before(:each) do
    8.times do
      FactoryGirl.create(:video_game, user_id: user.id)
      FactoryGirl.create(:video_game, user_id: user2.id)
    end
  end

  scenario 'returns some results on all games page' do
    video_games = VideoGame.all
    sign_in(user)

    visit video_games_path

    video_games.each { |game| expect(page).to have_content(game.title) }
    expect(video_games.count).to eq(16)
    video_games = video_games.to_a
    query = video_games.pop
    fill_in 'search', with: query.title
    click_button 'Search'

    expect(page).to have_content(query.title)
    video_games.each { |game| expect(page).not_to have_content(game.title) }
  end

  scenario 'returns no results on all games page' do
    video_games = VideoGame.all
    sign_in(user)

    visit video_games_path

    fill_in 'search', with: "no match will be found"
    click_button 'Search'

    expect(page).to have_content("There are no video games matching 'no match will be found'")
    video_games.each { |game| expect(page).not_to have_content(game.title) }
  end

  scenario 'returns some results on user games page' do
    video_games = user.video_games
    sign_in(user)

    visit user_games_path

    video_games.each { |game| expect(page).to have_content(game.title) }
    expect(video_games.count).to eq(8)
    video_games = video_games.to_a
    query = video_games.pop
    fill_in 'search', with: query.title
    click_button 'Search'

    expect(page).to have_content(query.title)
    video_games.each { |game| expect(page).not_to have_content(game.title) }
  end

  scenario 'returns no results on user games page' do
    video_games = user.video_games
    sign_in(user)

    visit video_games_path

    fill_in 'search', with: "no match will be found"
    click_button 'Search'

    expect(page).to have_content("There are no video games matching 'no match will be found'")
    video_games.each { |game| expect(page).not_to have_content(game.title) }
  end
end
