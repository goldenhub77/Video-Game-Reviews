require 'rails_helper'

feature 'user signs in', %q(
  As an unauthenticated user
  I want to sign in
  So that I can post items and review them
) do
  scenario 'sucessfully' do
    visit new_user_session_path
    user = FactoryGirl.create(:user)

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'

    expect(page).to have_content('Sign Out')
    expect(page).not_to have_content('Log In')
    expect(page).to have_link('Create New Game')
    expect(page).to have_content('Signed in successfully.')
  end

  scenario 'fails' do
    visit new_user_session_path

    fill_in 'Email', with: 'unknown@email.com'
    fill_in 'Password', with: 'badpassword'
    click_button 'Log In'

    expect(page).to have_content('Invalid Email or password.')

    visit root_path

    expect(page).not_to have_link('Create New Game')
  end
end
