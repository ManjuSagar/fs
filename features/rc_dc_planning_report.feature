Feature: RC/DC Planning Report
  Background:
    Given I visit "signin" page
    And I log in as "info@mymetrohc.com" and password "515253tt"
    Then I wait till i should see "FasterNotes is intended for business use only"
    When I press "OK"
    Then I wait till i should see "Patients"
    When I go to main menu "reports" page
    Then I wait till i should see "Notes Pending Agency Review"
    When I go to "RC/DC Planning" node in "reports" menu
    Then I wait till i should see "Episode End Date"

  @javascript

  Scenario: Current Month Active Treatments
    When I check ext checkbox "AC"
    When I select ext radio "Current Month"
    When I press "Ok"
    Then I wait till i should see "RC/DC Planning Report" or "No Records Found"

  @javascript

  Scenario: Previous Month Active Treatments
    When I check ext checkbox "AC"
    When I select ext radio "Previous Month"
    When I press "Ok"
    Then I wait till i should see "RC/DC Planning Report" or "No Records Found"

  @javascript

  Scenario: Next Month Active Treatments
    When I check ext checkbox "AC"
    When I select ext radio "Next Month"
    When I press "Ok"
    Then I wait till i should see "RC/DC Planning Report" or "No Records Found"

  @javascript

  Scenario: Custom date range Active Treatments
    When I check ext checkbox "AC"
    When I select ext radio "Custom"
    When I fill in "From Date*" with "07/22/2014"
    When I fill in "To Date*" with "08/22/2014"
    When I press "Ok"
    Then I wait till i should see "RC/DC Planning Report" or "No Records Found"

  @javascript

  Scenario: Current Month Active Treatments with Specific Case Manager
    When I check ext checkbox "AC"
    And I select ext radio "Current Month"
    And I expand combobox "Case Manager"
    Then I wait 2 seconds
    When I select "Suzanne Naoumovitch, RN" from combobox "Case Manager"
    And I wait 2 seconds
    When I press "Ok"
    Then I wait till i should see "RC/DC Planning Report" or "No Records Found"

  @javascript

  Scenario: Current Month Active and Hold Treatments
    When I check ext checkbox "AC"
    When I check ext checkbox "HD"
    And I select ext radio "Current Month"
    When I press "Ok"
    Then I wait till i should see "RC/DC Planning Report" or "No Records Found"