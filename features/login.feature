Feature: Log in
    As a user
    So that I can revisit or change my data
    I want to log into my account

Background: accounts in database

    Given the following accounts exist:
    | first_name        | last_name | username     | email          | password |
    | test              | ing       | user         | test@test.test | testing  |
    | test              | ing       | user2        | test@tamu.edu  | testing  |

Scenario: I login successfully
	Given I am on the login page
	When I fill out the login form with email="test@test.test", password="testing"
    And I click "Login"
	Then I should be on the listings page
    
Scenario: I login with wrong password
	Given I am on the login page
	When I fill out the login form with email="test@test.test", password="wrongPass"
    And I click "Login"
	Then I should see "Incorrect email or password"

Scenario: I login with an invalid email
	Given I am on the login page
	When I fill out the login form with email="typo@test.com", password="pass"
    And I click "Login"
	Then I should see "Incorrect email or password"