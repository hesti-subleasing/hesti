Feature: Delete Listing
    As a student
    So can remove my listing from the site
    I want to delete my listing

    
Background: accounts in database
    
    Given the following accounts exist:
    | first_name        | last_name | username     | email          | password | id |
    | test              | ing       | user         | test@test.test | testing  | 1  |
    | test              | ing       | user2        | test@tamu.edu  | testing  | 2  |

    Given the following listings exist:
    | title     | address_line_1 | city            | state   | zip_code | rent  | id | apt_complex | user_id |
    | listing1  | place          | CollegeStation  | TX      | 77777    | 1000  | 1  | hi          | 1       |
    | listing2  | place          | Bryan           | TX      | 77777    | 500   | 2  | hi          | 2       |

Scenario: Delete listing
    Given I am logged in as user
    And I am on the profile page
    And I press "Delete Listing" within "#listing-1"
    # Then I should be on the listing details page for id 1
    # And I should see "New Title"

Scenario: Edit listing not owned by user
    Given I am logged in as user
    And I am on the edit listing page for id 2
    Then I should see "Listings"
    
