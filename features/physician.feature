Feature: Home Health Agency Physicians List
  Background:
    Given I visit "signin" page
    Given I log in as "info@mymetrohc.com" and password "test1234"
    When I wait 5 seconds
    When I press "OK"
    When I wait 10 seconds
    Then I should see "Patients"

  @javascript
  Scenario: Add Physician
    When I go to main menu "physician" page
    Then I wait 5 seconds
    When I press with id "add_physician_button"
    Then I wait 5 seconds
    When I fill in "Name:*" with "Praveen1"
    Then I wait 3 seconds
    When I fill in "Kumar1" for "Last Name"
    Then I wait 3 seconds}
    When I fill in "2080 Century Park East" for "Street Address"
    Then I wait 3 seconds
    When I fill in "1231" for "Suite #"
    Then I wait 3 seconds
    When I fill in "90013" for "ZIP Code"
    Then I wait 3 seconds
    When I fill in "Los Angeles" for "City"
    Then I wait 3 seconds
    When I fill in "California" for "State"
    Then I wait 3 seconds
    When I fill in "NPI/Phone/Fax:*" with "3948989899"
    Then I wait 5 seconds
    When I fill in "(999) 999-9999" for "Phone Number"
    Then I wait 5 seconds
    When I fill in "(999) 999-9999" for "Fax Number"
    Then I wait 3 seconds
    When I fill in "praveenkumar123@gmail.com" for "MO Recipient Email"
    Then I wait 3 seconds
    When I fill in "(999) 999-9999" for "Pvt Phone 1"
    Then I wait 3 seconds
    When I fill in "(999) 999-9999" for "Pvt Phone 2"
    Then I wait 3 seconds
    When I press "Save" within "save"
    Then I wait 5 seconds
    When I press OK
    When I wait 3 seconds
    Then I wait for the response from the server
    When I wait 5 seconds
    Then I should see the record with "NPI Number" "4567789099"  with in grid "physician_list"
    Then I wait 5 seconds

  @javascript
  Scenario: Edit Physician non specific organization details

  @javascript
  Scenario: Edit Physician specific organization details
