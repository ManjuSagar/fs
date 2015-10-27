Feature: HHA Insurance Companies List
  Background:
    Given I visit "signin" page
    And I log in as "info@mymetrohc.com" and password "test1234"
    When I wait 5 seconds
    Then I press "OK"
    And I wait 10 seconds
    Then I should see "Patients"

  @javascript
  Scenario: Add Insurance Company Information
    When I go to main menu "insurance_company" page
    When I wait 10 seconds
    When I press with id "add_ins_compny_button"
    When I wait 5 seconds
    When I fill in "Name" with "MET LIFE"
    When I fill in "Code" with "AXA"
    When I fill in "Address" with "West Wood Street"
    When I fill in "Suite #" with "123"
    When I fill in "ZIP Code" with "90012"
    When I fill in "City" with "Los Angeles"
    When I fill in "State" with "CA"
    When I press "Save" within "add_ins_cmpny"
    Then I wait 5 seconds
    When I press OK
    Then I wait for the response from the server
    When I wait 5 seconds
    Then I should see the record with "Name" "MET LIFE"  with in grid "ins_cmpns_list"
    Then I wait 10 seconds

  Scenario: Edit Insurance Company Information
    When I go to main menu "insurance_company" page
    When I wait 10 seconds
    When I press with id "edit_ins_compny_button"
    Then I wait 10 seconds
    When I press "Save"
    Then I wait 5 seconds
    When I press OK
    When I wait 3 seconds
    Then I wait for the response from the server
    Then I wait 5 seconds


