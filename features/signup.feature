Feature: Create an account
    As a student
    So that I can find a listing
    I want to create an account

Scenario: I create a new account
	Given I am on the signup page
	When I fill out the form with first=b, last=g, username=blue, email=blue@gmail.com, password=blue
    And I click "Sign Up"
	Then I should see my profile page

Scenario: I attempt to create an account with a duplicate username
    Given I am on signup
    And there is an account with username "user"
    When I create an account with username "user"
    Then I should see "Username taken"

Scenario: I attempt to create an account with a duplicate email
    Given I am on signup
    And there is an account with email "test@tamu.edu"
    When I create an account with email "test@tamu.edu"
    Then I should see "An account with this email already exists"

Scenario: I attempt to create an account with mismatching passwords
    Given I am on signup
    When I create an account with password "pass"
    And I confirm the password as "wrongPass"
    Then I should see "Passwords do not match"