Feature: Logout
    As a user
    So that I can revisit or change my data
    I want to log into my account

Background: accounts in database

    Given the following accounts exist:
    | first_name        | last_name | username     | email          | password |
    | test              | ing       | user         | test@test.test | testing  |

Scenario: I logout successfully
	Given I am logged in as user
    And I am on the home page
    And I click "Log out"
	Then I should see "Log in"