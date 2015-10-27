Feature: HHA Associated Field Staff List
Background:
  Given I visit "signin" page
  And I log in as "info@mymetrohc.com" and password "test1234"
  When I wait 5 seconds
  Then I press "OK"
  And I wait 10 seconds
  Then I should see "Patients"

  @javascript
  Scenario: Add Field Staff

  @javascript
  Scenario: Edit Field Staff
    When I go to main menu "associated_field_staff_list" page
    Then I wait 20 seconds
    When I select row 3 of the grid with id "associated_field_staff_grid"
    Then I wait 3 seconds
    When I press with id "field_staff_details"
    Then I wait 10 seconds
    When I click on tab "rates"
    Then I wait 15 seconds
    When I click on tab "patients"
    Then I wait 10 seconds
    When I double click row 2 of the grid with id "patients"
    Then I wait 10 seconds


  @javascript
  Scenario: Delete Field Staff