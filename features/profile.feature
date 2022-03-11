Feature: Profile
    As a student
    So that I can view the information tied to my account
    I want to to view my profile page

Background: accounts in database

    Given the following organizations exist:
    | name | color   | id |
    | tamu | #a3ccd7 | 1  |

    Given the following accounts exist:
    | first_name        | last_name | username     | email          | password | organization_id |
    | test              | ing       | user         | test@test.test | testing  | 1               |

Scenario: I view my profile page
	Given I am logged in as user
    When I am on the profile page
    Then I should see "test"
    And I should see "tamu"

Scenario: I delete my account
	Given I am logged in as user
    And I am on the profile page
	When I click "Deactivate my Account"
    Then I should be on the home page
    And I should see "Log in"

Scenario: I try to view profile without being logged in
    Given I am on the profile page
    Then I should be on the login page