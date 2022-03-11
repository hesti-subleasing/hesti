Feature: Request Listing
    As a student
    So can show my interest in a sublease listing
    I want the ability to request a sublease

    
Background: accounts in database
    
    Given the following accounts exist:
    | first_name        | last_name | username     | email          | password | id |
    | test              | ing       | user         | test@test.test | testing  | 1  |
    | test              | ing       | user2        | test@tamu.edu  | testing  | 2  |

    Given the following listings exist:
    | title     | address_line_1 | city            | state   | zip_code | rent  | id | apt_complex | user_id |
    | listing1  | place          | CollegeStation  | TX      | 77777    | 1000  | 1  | hi          | 1       |
    | listing2  | place          | Bryan           | TX      | 77777    | 500   | 2  | hi          | 1       |

Scenario: Request listing
    Given I am logged in as user2
    And I am on the listing details page for id 1
    And I click "Request"
    Then I should see "Cancel Request"

Scenario: Cancel listing request
    Given I am logged in as user2
    And I am on the listing details page for id 1
    And I click "Request"
    And I click "Cancel Request"
    Then I should see "Request"
    
