Feature: View listing details
    As a student
    So that I can see all of the information about a listing
    I want to view the listing
    
Background: listings in database

    Given the following organizations exist:
    | name | color   | id |
    | tamu | #a3ccd7 | 1  |
    | acc  | #00205b | 2  |
    
    Given the following accounts exist:
    | organization_id | first_name        | last_name | username     | email          | password | id |
    | 1               | test              | ing       | user         | test@test.test | testing  | 1  |
    | 2               | test              | ing       | user2        | test@tamu.edu  | testing  | 2  |

    Given the following listings exist:
    | title     | address_line_1 | city            | state   | zip_code | rent  | apt_complex | id | user_id |
    | listing1  | place          | CollegeStation  | TX      | 77777    | 1000  | apt         | 1  | 1       |
    | listing2  | place          | Bryan           | TX      | 77777    | 500   | apt         | 2  | 2       |


Scenario: I view listing details
	Given I am logged in as user
    And I am on the listing details page for id 1
	Then I should see "listing1"
	And I should see "1000"

Scenario: I try to view a listing outside of my organization
	Given I am logged in as user2
    And I am on the listing details page for id 1
	Then I should be on the listings page
# filtering