Feature: View all listings
    As a student
    So that I can find a potential sublease
    I want to view all listings currently available
    
Background: listings in database
    
    Given the following accounts exist:
    | first_name        | last_name | username     | email          | password | id |
    | test              | ing       | user         | test@test.test | testing  | 1  |
    | test              | ing       | user2        | test@tamu.edu  | testing  | 2  |

    Given the following listings exist:
    | title     | address_line_1 | city            | state   | zip_code | rent  | id |
    | listing1  | place          | CollegeStation  | TX      | 77777    | 1000  | 1  |
    | listing2  | place          | Bryan           | TX      | 77777    | 500   | 2  |


Scenario: I view the listings page
	Given I am on the listings page
	Then I should see "listing1"
	And I should see "listing2"