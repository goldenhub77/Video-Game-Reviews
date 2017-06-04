require 'rails_helper'

feature 'user updates an existing video game', %q(
  As an authenticated user
  I want to be able to update a video game
  I created when information may change
) do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:platform) { FactoryGirl.create(:platform) }
  let!(:genre) { FactoryGirl.create(:genre) }
  let!(:video_game) { FactoryGirl.create(:video_game, user_id: user.id) }

  it 'sucessfully' do
    visit root_path
    sign_in(user)
    visit edit_video_game_path(video_game.id)


    fill_in 'Title', with: 'Overwatch'
    fill_in 'Developer', with: 'Blizzard Entertainment'
    fill_in 'Description', with: game.description
    check "video_game_platforms_#{platform.id}"
    fill_in 'Release Date', with: '06/10/2015'

    click_button 'Update Game'

    expect(page).to have_content('You have created Overwatch successfully')
  end

  it 'fails with bad data' do
    visit root_path
    sign_in(user)
    visit edit_video_game_path(video_game.id)

    fill_in 'Title', with: ''
    fill_in 'Developer', with: ''
    fill_in 'Description', with: ''
    fill_in 'Date', with: ''

    click_button 'Update Game'

    expect(page).to have_content('Errors to be on page')
  end

  it 'fails by no user logged in' do

    visit edit_video_game_path(video_game.id)

    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
