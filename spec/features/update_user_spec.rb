require 'rails_helper'

feature 'existing user updates information', %q(
  As an unauthenticated user
  I want to sign in
  So that I can post items and review them
) do
  it 'sucessfully' do
    visit new_user_session_path
    user = FactoryGirl.create(:user)

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    click_link 'Edit'

    fill_in 'Last Name', with: "Bond"

    click_button 'Update'

    expect(page).to have_content('Sign Out')
    expect(page).not_to have_content('Sign In')
    expect(page).to have_content('You have successfully updated you account')
    expect(user.last_name).to eq("Bond")
  end
end
