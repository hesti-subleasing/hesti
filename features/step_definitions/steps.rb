require 'uri'
require 'cgi'
require 'capybara/rails'
require 'capybara/cucumber'
require 'capybara/session'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end
World(WithinHelpers)

Given /^I am on (.+)$/ do |page_name|
    visit path_to(page_name)
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

When /^I fill out the form(?: with(?: first="([^,]*)",?)?(?: last="([^,]*)",?)?(?: username="([^,]*)",?)?(?: email="([^,]*)",?)?(?: password="([^,]*)",?)?(?: password_confirmation="([^,]*)")?)?$/ do |first, last, username, email, password, password_confimation|
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

And /^I click "([^\"]+)"/ do |button|
    click_button(button)
end

Then /^I should see "([^\"]+)"$/ do |text|
    page.should have_content(text)
end

Given /the following accounts exist/ do |accounts_table|
  accounts_table.hashes.each do |account|
    User.create account
  end
end

When /^I create an account with username "user"$/ do
  step "I fill out the form with username=user"
  step "I click \"Sign Up\""
end

