require 'rails_helper'

feature 'user deletes account', %q(
  As an authenticated user
  I want to delete my account
  So that my information is no longer retained by the app
) do

  let!(:user) { FactoryGirl.create(:user) }

  it 'sucessfully' do
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log In'
    click_link 'Edit Account'

    click_button 'Cancel my account'

    expect(page).to have_content('Sign Up')
    expect(page).to have_content('Sign In')
    expect(page).to have_content('Bye! Your account has been successfully cancelled. We hope to see you again soon.')

    expect{ User.find(user.id) }.to raise_exception(ActiveRecord::RecordNotFound)
  end
end
