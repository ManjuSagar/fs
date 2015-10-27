Feature: Patient Chart Disciplines
  Background:
    Given I visit "signin" page
    Given I log in as "info@mymetrohc.com" and password "515253tt"
    When I wait 5 seconds
    When I press "OK"
    When I wait 10 seconds
    Then I should see "Patients"
    When I open chart with patient name "James Smith" with episode "02/24/14 - 04/24/14"
    When I wait 5 seconds
    Then I should see "Patient Profile"
    When I wait 5 seconds
    Then I should see "Chart"
    When I wait 5 seconds
    When I go to "Disciplines" node within like "Cert 02/24/14"
    When I wait 5 seconds

  @javascript
  Scenario: Add Disciplines
    When I wait 3 seconds
    Then I press with id "discipline_add_btn"
    When I wait 5 seconds
    When I expand combobox "Disciplines"
    Then I wait 3 seconds"
    Then I select "Occupational Therapy" from combobox "Disciplines"
    Then I wait 3 seconds"
    When I press "Save"
    Then I wait 5 seconds
    When I press OK
    Then I wait 3 seconds
#  @javascript
#  Scenario: Discipline hold action

#  @javascript
#  Scenario: Discipline discharge action