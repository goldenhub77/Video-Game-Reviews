require 'rails_helper'

feature 'user visits admin console', %q(
  As an authenticated admin
  I want to be able be able to navigate to the
  administrator console
) do

  let!(:admin) { FactoryGirl.create(:user, role: 'admin') }
  let!(:user) { FactoryGirl.create(:user) }


  scenario 'sucessfully' do
    sign_in(admin)
    visit root_path

    click_link 'Administration'

    expect(page).to have_content("Administrators Console")
    expect(page).to have_content("Video Games")
    expect(page).to have_content("Users")
    expect(page).to have_content("Reviews")

  end

  scenario 'as a member user role' do
    sign_in(user)
    visit root_path

    expect(page).not_to have_link("Administration")

    visit admins_path

    expect(page).not_to have_content("Administrators Console")
    expect(page).to have_content("You are not authorized.")
  end
end
