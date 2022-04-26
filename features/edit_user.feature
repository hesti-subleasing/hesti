Feature: Edit User
    As a student
    So that I update my user information to be accurate
    I want to edit my listing

    
Background: accounts in database
    
    Given the following accounts exist:
    | first_name        | last_name | username     | email          | password | id |
    | test              | ing       | user         | test@test.test | testing  | 1  |

Scenario: Edit user while logged in
    Given I am logged in as user
    And I am on the profile page
    When I click "Edit Account"
    And I fill in "user_first_name" with "New"
    And I fill in "user_password" with "testing"
    And I fill in "user_password_confirmation" with "testing"
    And I click "Submit"
    Then I should be on the profile page
    And I should see "New"

Scenario: Edit user not logged in
    Given I am on the edit user page
    Then I should be on the home page
    And I should see "Log in"
    
