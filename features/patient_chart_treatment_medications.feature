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
    When I go to "Medications" node
    Then I wait 5 seconds

#  @javascript
#  Scenario: Add Treatment Medication
#    When I press with id "add_medication_button"
#    Then I wait 5 seconds
##    When I add medication with in patient chart
#    When I expand combobox "Episode"
#    Then I wait 3 seconds
#    When I select "02/24/14 - 04/24/14" from combobox "Episode"
#    Then I wait 3 seconds
#    When I fill in "SARISOL NO. 1 (15MG)" for "Name"
#    Then I wait 3 seconds
#    When I fill in "1wk2" for "Frequency"
#    Then I wait 3 seconds
#    When I select "N" from combobox "N/C"
#    Then I wait 3 seconds
#    When I press "Save" within "medication_form"
#    Then I wait 5 seconds
#    When I press OK
#    Then I wait 3 seconds
#    Then I wait for the response from the server
#    When I wait 10 seconds
#
#  @javascript
#  Scenario: Edit Treatment Medication
#    When I select row 1 of the grid with id "active_medications_list"
#    When I double click row 1 of the grid with id "active_medications_list"
#    Then I wait 5 seconds
##    When I edit treatment medication with in patient chart
#    When I fill in "AMLODIPINE BESYLATE AND VALSARTAN (EQ 10MG BASE;320MG)" for "Name"
#    Then I wait 3 seconds
#    When I fill in "1wk2" for "Frequency"
#    Then I wait 3 seconds
#    When I select "N" from combobox "N/C"
#    Then I wait 3 seconds
#    When I fill in "No" for "Potential Side Effects"
#    Then I wait 3 seconds
#    When I press "Save" within "medication_form"
#    Then I wait 5 seconds
#    When I press OK
#    Then I wait 3 seconds
#    Then I wait for the response from the server
##   When I wait 5 seconds
#
#  @javascript
#  Scenario: Delete Treatment Medication
#    When I select row 3 of the grid with id "active_medications_list"
#    When I press "Delete"
#    When I wait 5 seconds
#    When I press "Yes"
#    Then I wait 10 seconds
#    And I wait 5 seconds

#  @javascript
#  Scenario: Discontinue Treatment Medication
#

  @javascript
  Scenario: Print Treatment Medication
    When I select row 1 of the grid with id "active_medications_list"
    When I press "Print medication list"
    Then I wait 10 seconds
    When I fill in "04/07/2014" for "Date"
    Then I wait 3 seconds
    When I press "OK"
    Then I wait 15 seconds
    When I press close button in window with title "Medication List"
    Then I wait 10 seconds