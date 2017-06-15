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

  scenario 'returns search some results on all games page' do
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
    video_games.each { |game| expect(page).not_to have_content(game.title, exact: true) }
  end

  scenario 'returns no results on all games page' do
    video_games = VideoGame.all
    sign_in(user)

    visit video_games_path
    # http://localhost:9292/users/4/video_games?utf8=%E2%9C%93&search=test&url=%2Fusers%2F4%2Fvideo_games&page_type=video_games
    fill_in 'search', with: "no match will be found"
    click_button 'Search'

    expect(page).to have_content("There are no results matching the term 'no match will be found'")
    video_games.each { |game| expect(page).not_to have_content(game.title, exact: true) }
  end

  scenario 'returns search results on user games page' do
    video_games = user.video_games
    sign_in(user)

    visit user_video_games_path(user.id)

    video_games.each { |game| expect(page).to have_content(game.title) }
    expect(video_games.count).to eq(8)
    video_games = video_games.to_a
    query = video_games.pop
    fill_in 'search', with: query.title
    click_button 'Search'

    expect(page).to have_content(query.title)
    video_games.each { |game| expect(page).not_to have_content(game.title, exact: true) }
  end

  scenario 'returns no results on user games page' do
    video_games = user.video_games
    sign_in(user)

    visit video_games_path

    fill_in 'search', with: "no match will be found"
    # http://localhost:9292/users/4/video_games?utf8=%E2%9C%93&search=test&url=%2Fusers%2F4%2Fvideo_games&page_type=video_games
    click_button 'Search'

    expect(page).to have_content("There are no results matching the term 'no match will be found'")
    video_games.each { |game| expect(page).not_to have_content(game.title, exact: true) }
  end
end
