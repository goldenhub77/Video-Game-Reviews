require 'rails_helper'

feature 'user signs up', %q(
  As a prospective user
  I want to create an account
  So that I can post items and review them
) do
  it 'sucessfully' do
    visit new_user_registration_path

    fill_in 'First Name', with: 'John'
    fill_in 'Last Name', with: 'Smith'
    fill_in 'Email', with: 'test123@abc.com'
    fill_in 'user_password', with: 'Pa$$word'
    fill_in 'Password Confirmation', with: 'Pa$$word'
    click_button 'Sign Up'

    expect(page).to have_content('Sign Out')
    expect(page).to have_content('You have signed up successfully.')
  end

  it 'fails' do
    visit new_user_registration_path

    fill_in 'First Name', with: ''
    fill_in 'Last Name', with: ''
    fill_in 'Email', with: 'test123.com'
    fill_in 'user_password', with: 'Pa$$word'
    fill_in 'Password Confirmation', with: 'Password'
    click_button 'Sign Up'

    expect(page).to have_content('4 errors in user form.')
    expect(page).to have_content('Email is invalid')
    expect(page).to have_content("Password confirmation doesn't match Password")
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")

  end
end
