require 'rails_helper'

feature 'user creates a new video game', %q(
  As an authenticated user
  I want to create a new video game
  so users can make reviews on it
) do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:platform) { FactoryGirl.create(:platform) }
  let!(:genre) { FactoryGirl.create(:genre) }

  scenario 'sucessfully' do

    visit root_path

    expect(page).not_to have_content('Create New Game')

    sign_in(user)

    visit root_path

    expect(page).to have_content('Create New Game')

    click_link 'Create New Game'

    fill_in 'Title', with: 'Overwatch'
    fill_in 'Developer', with: 'Blizzard Entertainment'
    fill_in 'Description', with: "This is a description to prove a video game can be created."
    select "genre1", from: "video_game_genre_id"
    fill_in 'Release Date', with: '2016-05-06'
    check "platform1"

    click_button 'Create Video game'



    expect(page).to have_content('You successfully added Overwatch')
  end

  scenario 'fails with bad data' do

    sign_in(user)
    visit new_video_game_path

    click_button 'Create Video game'

    expect(page).to have_content('8 errors in video game form.')
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content('Title is too short (minimum is 5 characters)')
    expect(page).to have_content("Developer can't be blank")
    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content('Description is too short (minimum is 15 characters)')
    expect(page).to have_content("Platforms can't be blank")
    expect(page).to have_content("Genre can't be blank")
    expect(page).to have_content("Release date can't be blank")
  end

  scenario 'fails by no user logged in' do

    visit new_video_game_path

    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
