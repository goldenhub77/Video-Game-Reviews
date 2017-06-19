require 'rails_helper'
include ApplicationHelper

feature 'admin shows user profile', %q(
  As an authenticated admin
  I want to be able to show a user profile
  So that a users account will display its show page from the admins page
) do

  let!(:admin) { FactoryGirl.create(:user, role: 'admin') }
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'sucessfully' do

    sign_in(admin)

    visit admins_path

    click_button "admin-show-user-#{user.id}"

    expect(page).to have_content(user.full_name)
    expect(page).to have_content(user.role)
    expect(page).to have_content(user.email)
    expect(page).to have_content(object_date_joined(user))
  end
end
