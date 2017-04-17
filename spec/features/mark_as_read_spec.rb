require "rails_helper"

RSpec.describe "can mark links as read", :js => :true do
  before do
    User.create(email:'jason@conrad.com', password: 'password' )
    visit "/login"
    fill_in "email", with: 'jason@conrad.com'
    fill_in "password", with: 'password'
    click_on ("Submit")
    visit "/links"
    fill_in :url, with: "http://www.google.com"
    fill_in :title, with: "Google Ninja"
    click_on "Submit"
  end
  scenario "Mark a link as read" do
    visit '/'
    within(".card") do
      expect(page).to have_text("false")
    end

    click_on "Mark as Read"
    visit '/'
    within(".card") do
      expect(page).to have_text("true")
    end

  end
end
