Feature: Favorite Listing
    As a student
    So can keep track of my favorite listings
    I want the ability to favorite a listing

    
Background: accounts in database
    
    Given the following accounts exist:
    | first_name        | last_name | username     | email          | password | id |
    | test              | ing       | user         | test@test.test | testing  | 1  |
    | test              | ing       | user2        | test@tamu.edu  | testing  | 2  |

    Given the following listings exist:
    | title     | address_line_1 | city            | state   | zip_code | rent  | id | apt_complex | user_id |
    | listing1  | place          | CollegeStation  | TX      | 77777    | 1000  | 1  | hi          | 2       |
    | listing2  | place          | Bryan           | TX      | 77777    | 500   | 2  | hi          | 2       |

# Scenario: Favorite a listing
#     Given I am logged in as user
#     And I am on the favorites page for id 1
#     And I select "favorite_true" within "#listing-1"
#     And I am on the profile page
#     Then "listing1" should be in my favorites
    
