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
    And I wait 5 seconds
    When I go to "Physician" node
    Then I wait 10 seconds

  @javascript
  Scenario: Add Treatmetnt Physician
    When I press with id "add_treatment_physician"
    Then I wait 5 seconds
#    When I add treatment physician with in patient chart
    When I expand combobox "Physician"
    Then I wait 3 seconds
    When I select "Thomas Ahn, MD" from combobox "Physician"
    Then I wait 3 seconds
    When I check ext checkbox "Primary Physician?"
    Then I wait 3 seconds
    When I check ext checkbox "Require CC?"
    Then I wait 3 seconds
    When I press "Save" within "save"
    Then I wait 5 seconds
    When I press OK
    Then I wait 5 seconds
    Then I wait for the response from the server
    Then I should see "Thomas Ahn, MD"
    Then I wait 5 seconds

  @javascript
  Scenario: Edit Treatmetnt Physician
    When I select row 2 of the grid with id "treatment_physicians"
    When I double click row 3 of the grid with id "treatment_physicians"
    Then I wait 5 seconds
#    When I edit treatment physician with in patient chart
    When I uncheck ext checkbox "Primary Physician?"
    Then I wait 3 seconds
    When I press "Save" within "save"
    Then I wait 5 seconds
    When I press OK
    Then I wait 5 seconds
    Then I wait for the response from the server
    When I wait 10 seconds

  @javascript
  Scenario: Delete Treatmetnt Physician
    When I select row 3 of the grid with id "treatment_physicians"
    Then I wait 3 seconds
    When I press "Delete"
    When I wait 5 seconds
    When I press "Yes"
    Then I wait 10 seconds
    And I wait 5 seconds
