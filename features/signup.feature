Feature: Create an account
    As a student
    So that I can find a listing
    I want to create an account

Background: accounts in database

    Given the following accounts exist:
    | first_name        | last_name | username     | email          | password |
    | test              | ing       | user         | test@test.test | testing  |
    | test              | ing       | user2        | test@tamu.edu  | testing  |

Scenario: I create a new account
	Given I am on the signup page
	When I fill out the signup form with first="b", last="g", username="blue", email="blue@gmail.com", password="blue"
    And I click "Sign Up"
    Then I should see "Listings"

Scenario: I attempt to create an account with a duplicate username
    Given I am on the signup page
    When I sign up with username="user"
    And I click "Sign Up"
    Then I should see "Username has already been taken"

Scenario: I attempt to create an account with a duplicate email
    Given I am on the signup page
    When I sign up with email="test@tamu.edu"
    And I click "Sign Up"
    Then I should see "Email has already been taken"

Scenario: I attempt to create an account with mismatching passwords
    Given I am on the signup page
    When I sign up with password="pass", password_confirmation="wrongPass"
    And I click "Sign Up"
    Then I should see "Password confirmation does not match"