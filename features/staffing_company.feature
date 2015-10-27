Feature: Home Health Agency Staffing Company List
  Background:
    Given I visit "signin" page
    Given I log in as "info@mymetrohc.com" and password "test1234"
    When I wait 5 seconds
    When I press "OK"
    When I wait 10 seconds
    Then I should see "Patients"
    When I go to main menu "staffing_company_list" page
    Then I wait 5 seconds

  @javascript
  Scenario: Add Staffing Company
    And I press with id "add_staffing_company_button"
    Then I wait 5 seconds
    When I fill in "ABC Home Health Care" for "Name"
    Then I wait 3 seconds
    When I fill in "10747 Wilshire Blvd." for "Address"
    Then I wait 3 seconds
    When I fill in "90013" for "Location"
    Then I wait 3 seconds
    When I fill in "fnpublic+abc@gmail.com" for "Email/Fed Tax"
    Then I wait 3 seconds
    When I fill in "4356567779" for "Fed Tax Number"
    Then I wait 3 seconds
    When I fill in "(989) 989-6544" for "Phone Number"
    Then I wait 3 seconds
    When I fill in "(765) 988-8777" for "Fax Number"
    Then I wait 3 seconds
    When I press "Save"
    Then I wait 5 seconds
    When I press OK
    When I wait 5 seconds
    Then I wait for the response from the server
    When I wait 5 seconds

  @javascript
  Scenario: Edit Staffing Company
    When I select row 6 of the grid with id "staffing_companies_list"
    And I press with id "edit_staffing_company_button"
    Then I wait 5 seconds
    When I fill in "(989) 989-6544" for "Phone Number"
    Then I wait 3 seconds
    When I fill in "(765) 988-8777" for "Fax Number"
    Then I wait 3 seconds
    When I click on "contracts" within "staffing_company_details"
    Then I wait 10 seconds
    When I select row 1 of the grid with id "contracts"
    Then I wait 3 seconds
    When I press "Save"
    Then I wait 5 seconds
    When I press OK
    When I wait 5 seconds
    Then I wait for the response from the server
    When I wait 5 seconds

