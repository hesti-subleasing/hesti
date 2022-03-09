Feature: Create Listing
    As a student
    So that I can find someone to sublease my property
    I want to create a listing

    
Background: accounts in database
    
    Given the following accounts exist:
    | first_name        | last_name | username     | email          | password | id |
    | test              | ing       | user         | test@test.test | testing  | 1  |
    | test              | ing       | user2        | test@tamu.edu  | testing  | 2  |

Scenario: Create listing without required fields
    Given I am logged in as user
    And I am on the new listing page
    When I fill out the listing form
    And I click "Submit"
    Then I should be on the listing details page for id 1
