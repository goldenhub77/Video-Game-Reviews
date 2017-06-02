require 'rails_helper'

feature 'user creates a new video game', %q(
  As an authenticated user
  I want to create a new video game
  so users can make reviews on it
) do

  let!(:user) { FactoryGirl.create(:user) }

  it 'sucessfully' do
    visit root_path
    sign_in(user)
    visit new_video_game_path
    game = FactoryGirl.build(:video_game)

    fill_in 'Title', with: 'Overwatch'
    fill_in 'Developer', with: 'Blizzard Entertainment'
    fill_in 'Description', with: game.description
    check_box 'Platforms', with: ['Xbox', 'Windows', 'Playstation']
    fill_in 'Date', with: '5/16/17'

    click_button 'Create Video Game'

    expect(page).to have_content('You have created Overwatch successfully')
  end

  it 'fails with bad data' do
    visit root_path
    sign_in(user)
    visit new_video_game_path

    fill_in 'Title', with: ''
    fill_in 'Developer', with: ''
    fill_in 'Description', with: ''
    check_box 'Platforms', with: []
    fill_in 'Date', with: ''

    click_button 'Create Video Game'

    expect(page).to have_content('Errors to be on page')
  end

  it 'fails by no user logged in' do

    visit new_video_game_path

    expect(page).to have_content('You must be logged in to see this resource')
  end
end
