require 'rails_helper'

feature 'admin deletes user account', %q(
  As an authenticated admin
  I want to be able to delete an account
  So that a user will no longer be retained by the app
  if user agreement is breached
) do

  let!(:admin) { FactoryGirl.create(:user, role: 'admin') }
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'sucessfully' do
    sign_in(admin)

    visit admins_path

    click_button "admin-delete-user-#{user.id}"

    expect(page).to have_content("You successfully deleted #{user.full_name}")
    expect{ User.find(user.id) }.to raise_exception(ActiveRecord::RecordNotFound)
  end
end
