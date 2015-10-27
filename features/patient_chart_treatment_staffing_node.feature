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
    When I wait 5 seconds
    When I go to "Staffing" node
    Then I wait 20 seconds

  @javascript
  Scenario: Add Treatment Staffing
    When I press "Add"
    Then I wait 10 seconds
    When I expand combobox "Discipline"
    Then I wait 3 seconds
    When I select "Skilled Nursing" from combobox "Discipline"
    Then I wait 3 seconds
    When I expand combobox "Visit Type"
    Then I wait 3 seconds
    When I select "SOC-Eval" from combobox "Visit Type"
    Then I wait 3 seconds
    When I select ext radio "Show all staffs"
    Then I wait 3 seconds
    When I expand combobox "Staff"
    Then I wait for the response from the server
    When I select "Elena Kaminskaya, RN" from combobox "Staff"
    Then I wait 3 seconds
    When I press "Save"
    Then I wait 5 seconds
    When I press OK
    Then I wait 10 seconds

  @javascript
  Scenario: Edit Treatment Staffing
    When I select row 1 of the grid with id "treatment_staff_grid"
    When I double click row 1 of the grid with id "treatment_staff_grid"
    Then I wait 5 seconds
    When I expand combobox "Staff"
    Then I wait for the response from the server
    When I select "Lana Gevorkyan, RN" from combobox "Staff"
    Then I wait 3 seconds
    When I press "Save"
    Then I wait 5 seconds
    When I press OK
    Then I wait 3 seconds
    Then I wait for the response from the server
#    When I wait 10 seconds
  @javascript
  Scenario: Delete Treatment Staffing
    When I select first row in the grid
    When I wait 5 seconds
    When I press "Delete"
    When I wait 5 seconds
    When I press "Yes"
    When I wait 10 seconds

  @javascript
  Scenario: Broadcast Request
    When I press with id "broadcast_button"
    Then I wait 10 seconds
