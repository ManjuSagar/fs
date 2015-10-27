Feature: Unverified Medications
  Background:
    Given I visit "signin" page
    Given I log in as "fnpublic+zakharyan2@gmail.com" and password "test1234"
    And I wait 5 seconds
    When I press "OK"
    And I wait 10 seconds
    Then I should see "Patients"
    When I go to main menu "reports" page
    And I wait 10 seconds
    And I go to "Billed Claims" node in "reports" menu
    And I wait 10 seconds

  @javascript
  Scenario: Sent Date Filter
    When I fill in "02/05/2014" for "From"
    And I wait 3 seconds
    When I fill in "23/07/2014" for "To"
    And I wait 3 seconds
    And I press "Ok"
    And I wait 15 seconds
    And I wait for the response from the server
    And I press close button in window with title "Billed Claim Report"
    And I wait 5 seconds

  @javascript
  Scenario: Group By Claim Type
    When I fill in "02/05/2014" for "From"
    And I wait 3 seconds
    When I fill in "23/07/2014" for "To"
    And I wait 3 seconds
    When I expand combobox "Group By"
    Then I wait 5 seconds
    When I select "Claim Type" from combobox "Group By"
    And I wait 5 seconds
    And I press "Ok"
    And I wait 15 seconds
    And I wait for the response from the server
    And I press close button in window with title "Billed Claim Report"
    And I wait 5 seconds

  @javascript
  Scenario: Group By RAP
    When I fill in "02/05/2014" for "From"
    And I wait 3 seconds
    When I fill in "23/07/2014" for "To"
    And I wait 3 seconds
    When I expand combobox "Group By"
    Then I wait 5 seconds
    When I select "Sent Date" from combobox "Group By"
    And I wait 5 seconds
    And I press "Ok"
    And I wait 15 seconds
    And I wait for the response from the server
    And I press close button in window with title "Billed Claim Report"
    And I wait 5 seconds

  @javascript
  Scenario: Group By Expected Receive Date
    When I fill in "02/05/2014" for "From"
    And I wait 3 seconds
    When I fill in "23/07/2014" for "To"
    And I wait 3 seconds
    When I expand combobox "Group By"
    Then I wait 5 seconds
    When I select "Expected Receive Date" from combobox "Group By"
    And I wait 5 seconds
    And I press "Ok"
    And I wait 15 seconds
    And I wait for the response from the server
    And I press close button in window with title "Billed Claim Report"
    And I wait 5 seconds

  @javascript
  Scenario: Expected Receive Date Filter
    When I check ext checkbox "Expected Receive Date"
    And I wait 10 seconds
    When I fill in "02/05/2014" for "From"
    And I wait 3 seconds
    When I fill in "23/07/2014" for "To"
    And I wait 3 seconds
    And I press "Ok"
    And I wait 15 seconds
    And I wait for the response from the server
    And I press close button in window with title "Billed Claim Report"
    And I wait 5 seconds
