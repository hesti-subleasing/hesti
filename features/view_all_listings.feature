Feature: View all listings
    As a student
    So that I can find a potential sublease
    I want to view all listings currently available
    
Background: listings in database
    
    Given the following accounts exist:
    | first_name        | last_name | username     | email          | password |
    | test              | ing       | user         | test@test.test | testing  |
    | test              | ing       | user2        | test@tamu.edu  | testing  |

    Given the following listings exist:
    | title     | address_line_1 | city            | state   | zip_code | rent  |
    | listing1  | place          | CollegeStation  | TX      | 77777    | 1000  |
    | listing2  | place          | Bryan           | TX      | 77777    | 500   |


Scenario: I view the listings page
	Given I am on the listings page
	Then I should see "listing1"
	And I should see "listing2"