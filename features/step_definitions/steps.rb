require 'uri'
require 'cgi'
require 'capybara/rails'
require 'capybara/cucumber'
require 'capybara/session'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

# require SessionsConcern

module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end
World(WithinHelpers)

Given /the following accounts exist/ do |accounts_table|
  accounts_table.hashes.each do |account|
    User.create account
  end
end

Given /the following listings exist/ do |listings_table|
  listings_table.hashes.each do |listing|
    listing[:user_id] = User.first.id
    Listing.new(listing) do |l|
      if listing[:id]
        puts("changing listing id")
        l.id = listing[:id]
      end
      l.save
    end
  end
end

Given /^I am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

Given /^I am logged in as (.+)$/ do |username|
  user = User.where(username: user).first
  if user
    set_session_params(user)
  else
    p "errorr"
  end
end

Then /^I should be on (.+)$/ do |page_name|
    if current_path.respond_to? :expect
      current_path.should == path_to(page_name)
    else
      expect(page).to have_current_path(path_to(page_name))
      # assert_equal path_to(page_name), current_path
    end
end

When /^I press "([^\"]*)"(?: within "([^\"]*)")?$/ do |button, selector|
    with_scope(selector) do
      click_button(button)
    end
end

When /^I fill out the signup form with(?: first="([^,]*)",?)?(?: last="([^,]*)",?)?(?: username="([^,]*)",?)?(?: email="([^,]*)",?)?(?: password="([^,]*)",?)?(?: password_confirmation="([^,]*)")?$/ do |first, last, username, email, password, password_confimation|
  first ||= ""
  last ||= ""
  username ||= ""
  email ||= ""
  password ||= ""
  password_confimation ||= ""

  fill_in("user_first_name", :with => first)
  fill_in("user_last_name", :with => last)
  fill_in("user_username", :with => username)
  fill_in("user_email", :with => email)
  fill_in("user_password", :with => password)
  fill_in("user_password_confirmation", :with => password_confimation)
end

When /^I sign up with(?: first="([^,]*)",?)?(?: last="([^,]*)",?)?(?: username="([^,]*)",?)?(?: email="([^,]*)",?)?(?: password="([^,]*)",?)?(?: password_confirmation="([^,]*)")?$/ do |first, last, username, email, password, password_confimation|
    first ||= "TestFirst"
    last ||= "TestLast"
    username ||= "user"
    email ||= "test@tamu.edu"
    password ||= "pass"
    password_confimation ||= password

    fill_in("user_first_name", :with => first)
    fill_in("user_last_name", :with => last)
    fill_in("user_username", :with => username)
    fill_in("user_email", :with => email)
    fill_in("user_password", :with => password)
    fill_in("user_password_confirmation", :with => password_confimation)
end

When /^I fill out the login form(?: with(?: email="([^,]*)",?)?(?: password="([^,]*)",?)?)?$/ do |email, password|
  fill_in("email", :with => email)
  fill_in("password", :with => password)
end

When /^I fill out the listing form(?: with(?: title="([^,]*)",?)?(?: address_1="([^,]*)",?)?(?: address_2="([^,]*)",?)?(?: city="([^,]*)",?)?(?: state="([^,]*)",?)?(?: zip_code="([^,]*)",?)?(?: apt="([^,]*)",?)?(?: rent="([^,]*)",?)?(?: private_bed="([^,]*)",?)?(?: private_bath="([^,]*)",?)?(?: roommates="([^,]*)",?)?(?: beds="([^,]*)",?)?(?: baths="([^,]*)",?)?(?: pets="([^,]*)",?)?(?: description="([^,]*)",?)?)?$/ do |title, address_1, address_2, city, state, zip_code, apt, rent, private_bed, private_bath, roommates, beds, baths, pets, description|
  title ||= "Test Title"
  address_1 ||= "1234"
  address_2 ||= ""
  city ||= "TestCity"
  state ||= "Test"
  zip_code ||= "12345"
  apt ||= "TestApt"
  rent ||= 1000
  private_bed ||= "true"
  private_bed = private_bed.downcase == "true" ? true : false
  private_bath ||= "false"
  private_bath = private_bath.downcase == "true" ? true : false
  roommates ||= 4
  beds ||= 4
  baths ||= 4
  pets ||= 4
  description ||= "sdjflsjdfklsjdxf"

  fill_in("listing_title", :with => title)
  fill_in("listing_address_line_1", :with => address_1)
  fill_in("listing_address_line_2", :with => address_2)
  fill_in("listing_city", :with => city)
  fill_in("listing_state", :with => state)
  fill_in("listing_zip_code", :with => zip_code)
  fill_in("listing_apt_complex", :with => apt)
  fill_in("listing_rent", :with => rent)
  fill_in("listing_private_bedroom", :with => private_bed)
  fill_in("listing_private_bathroom", :with => private_bath)
  fill_in("listing_num_roommates", :with => roommates)
  fill_in("listing_num_beds", :with => beds)
  fill_in("listing_num_baths", :with => baths)
  fill_in("listing_num_pets", :with => pets)
  fill_in("listing_description", :with => description)
end

And /^I click "([^\"]+)"$/ do |button|
    click_button(button)
end

Then /^I should see "([^\"]+)"$/ do |text|
  page.should have_content(text)
end

When /^I create an account with username "user"$/ do
  step "I fill out the form with username=user"
  step "I click \"Sign Up\""
end

