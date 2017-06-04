require 'rails_helper'

feature 'existing user updates information', %q(
  As an authenticated user
  I want to update my account
) do

  let!(:user) { FactoryGirl.create(:user) }

  it 'sucessfully' do
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log In'
    click_link 'Edit Account'

    fill_in 'Last Name', with: 'Bond'
    fill_in 'Current Password', with: user.password

    click_button 'Update'

    expect(page).to have_content('Sign Out')
    expect(page).not_to have_content('Log In')
    expect(page).to have_content('Your account has been updated successfully.')

    updated_user = User.find(user.id)
    expect(updated_user.id).to eq(user.id)
  end

  it 'fails' do
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log In'
    click_link 'Edit Account'

    fill_in 'Last Name', with: 'Bond'
    fill_in 'Current Password', with: "wrong password"

    click_button 'Update'

    expect(page).to have_content('Sign Out')
    expect(page).not_to have_content('Log In')
    expect(page).to have_content('1 error in user form. Current password is invalid')

    updated_user = User.find(user.id)
    expect(updated_user.last_name).to eq(user.last_name)
  end
end
