require 'rails_helper'

describe "user creates a link and edits it" do
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

  scenario "user can visit the edit page" do

    visit '/'

    click_on "Edit Link"
    expect(current_path).to have_content("/links/#{Link.last.id}")
    expect(page).to have_button("Update Link")
  end

  scenario "user edits a link" do
    visit "/"

    click_on "Edit Link"

    fill_in "link[url]", with: "http://www.google.com"
    fill_in "link[title]", with: "Google"

    click_on "Update Link"

    expect(page).to_not have_content("Google Ninja")
  end

  scenario "user submits a link without a title" do
    visit "/"

    click_on "Edit Link"
    fill_in "link[url]", with: "http://www.google.com"
    fill_in "link[title]", with: ""

    click_on "Update Link"

    expect(page).to have_content("You didn't enter a title")
  end

  scenario "user submits a link without a url" do
    visit "/"

    click_on "Edit Link"

    fill_in "link[url]", with: ""
    fill_in "link[title]", with: "Google Ninja"

    click_on "Update Link"

    expect(page).to have_content("You didn't enter a URL")
  end

  scenario "user submits a form without filling in the fields" do
    visit "/"

    click_on "Edit Link"

    fill_in "link[url]", with: ""
    fill_in "link[title]", with: ""

    click_on "Update Link"

    expect(page).to have_content("You didn't enter any information")
  end
end
