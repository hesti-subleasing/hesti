require 'uri'
require 'cgi'
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
    current_path = URI.parse(current_url).path
    if current_path.respond_to? :expect
      current_path.should == path_to(page_name)
    else
      assert_equal path_to(page_name), current_path
    end
end

When /^I press "([^\"]*)"(?: within "([^\"]*)")?$/ do |button, selector|
    with_scope(selector) do
      click_button(button)
    end
end

When /^I fill out the form(?: with first=([^,]*), last=([^,]*), username=([^,]*), email=([^,]*), password=([^,]*))?$/ do |first, last, username, email, password|
    first ||= "TestFirst"
    last ||= "TestLast"
    username ||= "user"
    email ||= "test&tamu.edu"
    password ||= "pass"

    fill_in("user_first_name", :with => first)
    fill_in("user_last_name", :with => last)
    fill_in("user_username", :with => username)
    fill_in("user_email", :with => email)
    fill_in("user_password", :with => password)
end

And /^I click "([^\"]*)"/ do |button|
    click_button(button)
end

Then /^I should see my profile page$/ do
    page.should have_content("Profile")
end