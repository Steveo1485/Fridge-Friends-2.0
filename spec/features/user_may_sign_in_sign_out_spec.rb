require 'spec_helper'
include SignupHelper

feature "User may log in and log out" do
  before(:each) do
    visit root_path
  end

  let!(:user) { User.new(name: 'Carter1', email: 'carter11@example.com', password: 'password', phone_number: '407-774-9393', customer_id: '123456788') }

  scenario "with valid email and password", js: true do
    signup_user(user)
    click_link "logout"
    fill_in 'session_email', with: user.email
    fill_in 'session_password', with: user.password
    click_on "Sign in"

    expect(current_path).to eq root_path
    expect(page).to have_content "logout"
    expect(page).to have_content "Fridges"
  end

  scenario "with invalid email and password", js: true do
    fill_in 'session_email', with: ""
    fill_in 'session_password', with: ""
    click_on "Sign in"

    expect(current_path).to eq session_path
  end
end