Feature: Visit Types
Background:
  Given I visit "signin" page
  Given I log in as "info@mymetrohc.com" and password "515253tt"
  When I wait 5 seconds
  When I press "OK"
  When I wait 10 seconds
  Then I should see "Patients"

  @javascript
  Scenario: Visit Types disable
    When I go to main menu "visit_types_explorer" page
    When I wait 30 seconds
    When I click "Inactivate" action in row 1 of the grid with id "visit_types"
    When I wait 20 seconds

  @javascript
  Scenario: Visit Types activate
    When I go to main menu "visit_types_explorer" page
    When I wait 30 seconds
    When I uncheck ext checkbox "visit_types_active"
    When I check ext checkbox with id "visit_types_inactive"
    When I click "Activate" action in row 1 of the grid with id "visit_types"
    When I wait 20 seconds

  @javascript
  Scenario: View visit types sorted by visit type status and code
    When I go to main menu "visit_types_explorer" page
    When I wait 30 seconds

  @javascript
  Scenario: Active visit types
    When I go to main menu "visit_types_explorer" page
    When I wait 30 seconds
    When I check ext checkbox with id "visit_types_active"
    And I wait 10 seconds

  @javascript
  Scenario: Inactive visit types
    When I go to main menu "visit_types_explorer" page
    When I wait 30 seconds
    When I uncheck ext checkbox "visit_types_active"
    When I check ext checkbox with id "visit_types_inactive"
    And I wait 10 seconds

  @javascript
  Scenario: Active and Inactive visit types
    When I go to main menu "visit_types_explorer" page
    When I wait 30 seconds
    When I check ext checkbox with id "visit_types_active"
    When I check ext checkbox with id "visit_types_inactive"
    And I wait 10 seconds




