require 'rails_helper'

feature 'user signs out', %q(
  As an authenticated user
  I want to sign out
  So that no one else can post items or reviews on my behalf
) do
  it 'sucessfully' do
    visit new_user_sessions_path
    user = FactoryGirl.create(:user)

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Sign In'

    expect(page).to have_content('Sign Out')

    click_button 'Sign Out'

    expect(page).not_to have_content('Sign In')
    expect(page).to have_content('You have successfully signed out')
  end
end
