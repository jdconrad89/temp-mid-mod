require 'rails_helper'

describe "seeing a form for links" do
  context "the user is not logged in" do
    scenario "user cannot see the form to add a link" do

      visit "/links"

      expect(page).to_not have_content("Add a link here")
      expect(page).to_not have_content("Submit")
    end
  end

  context "the user is logged in" do
    before do
      User.create(email:'jason@conrad.com', password: 'password' )

      visit "/login"

      fill_in "email", with: 'jason@conrad.com'
      fill_in "password", with: 'password'

      click_on ("Submit")
    end

    scenario "user sees the form" do
      visit "/links"

      expect(page).to have_content("Add a link here")
      expect(page).to have_content("Url")
    end

    scenario "user submits a link" do
      visit "/links"

      expect(Link.count).to eq(0)

      fill_in :url, with: "http://www.google.com"
      fill_in :title, with: "Google Ninja"

      click_on "Submit"

      expect(page).to have_content("Google Ninja")
    end

    scenario "user submits a link without a title" do
      visit "/links"
      expect(Link.count).to eq(0)

      fill_in :url, with: "http://www.google.com"
      fill_in :title, with: ""

      click_on "Submit"

      expect(Link.count).to eq(0)
      expect(page).to have_content("You didn't enter a title")
    end

    scenario "user submits a link without a url" do
      visit "/links"

      expect(Link.count).to eq(0)

      fill_in :url, with: ""
      fill_in :title, with: "Google Ninja"

      click_on "Submit"

      expect(Link.count).to eq(0)
      expect(page).to have_content("You didn't enter a URL")
    end

    scenario "user submits a link with a bad link" do
      visit "/links"

      expect(Link.count).to eq(0)

      fill_in :url, with: "google.com"
      fill_in :title, with: "Google Ninja"

      click_on "Submit"

      expect(Link.count).to eq(0)
      expect(page).to have_content("The url you have entered is incorrect")
    end

    scenario "user submits a form without filling in the fields" do
      visit "/links"

      expect(Link.count).to eq(0)

      fill_in :url, with: ""
      fill_in :title, with: ""

      click_on "Submit"

      expect(Link.count).to eq(0)
      expect(page).to have_content("You didn't enter any information")
    end
  end
end
