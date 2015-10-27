Feature: Patient Chart Testing
  Background:
    Given I visit "signin" page
    Given I log in as "info@mymetrohc.com" and password "test1234"
    When I wait 5 seconds
    When I press "OK"
    When I wait 10 seconds
    Then I should see "Patients"
    When I open chart with patient name "James Smith" with episode "02/24/14 - 04/24/14"
    When I wait 5 seconds
    Then I should see "Patient Profile"
    When I wait 5 seconds
    Then I should see "Chart"
    Then I wait 5 seconds
    When I go to "Frequencies" node within like "Cert 02/24/14 "
    Then I wait 5 seconds

  @javascript
  Scenario: Add Frequency
    Then I press with id "add_visit_frequency"
    Then I wait 5 seconds
#   When I add frequency with in patient chart
    When I expand combobox "Episode"
    Then I wait 3 seconds
    When I select "02/24/14 - 04/24/14" from combobox "Episode"
    Then I wait 3 seconds
    When I expand combobox "Discipline"
    Then I wait 3 seconds
    When I select "Home Health Aide" from combobox "Discipline"
    Then I wait 3 seconds
    When I fill in "04/02/2014" for "Start Date"
    Then I wait 3 seconds
    When I fill in "1wk1" for "Frequency"
    Then I wait 3 seconds
    When I press "Save"
    Then I wait 5 seconds
    When I press OK
    Then I wait 3 seconds
    Then I wait 5 seconds
    Then I wait for the response from the server
    Then I wait 5 seconds

  @javascript
  Scenario: Replace Frequency

  @javascript
  Scenario: Delete Frequency