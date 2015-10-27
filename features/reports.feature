Feature: Reports
  Background:
    Given I visit "signin" page
    Given I log in as "info@mymetrohc.com" and password "515253tt"
    When I wait 5 seconds
    When I press "OK"
    When I wait 10 seconds
    Then I should see "Patients"

  @javascript

  Scenario: Missing Frequencies Report
    When I go to main menu "reports" page
    Then I wait 10 seconds
    When I go to "Missing Frequencies" node in "reports" menu
    Then I wait 10 seconds
    When I select ext radio "Field Staff"
    Then I wait 10 seconds
    When I expand combobox "Field Staff"
    Then I wait 10 seconds
    When I select "Suzanne Naoumovitch, RN" from combobox "Field Staff"
    Then I wait 10 seconds
    When I press "Ok"
    Then I wait for the response from the server
    And I wait 10 seconds
    When I press close button in window with title "Missing Frequencies"
    Then I wait 5 seconds

  @javascript
  Scenario: Therapy Re Evaluations Report
    When I go to main menu "reports" page
    Then I wait 10 seconds
    When I go to "Therapy Re- Evaluations" node in "reports" menu
    Then I wait 10 seconds
    When I select ext radio "Staffing Company"
    Then I wait 10 seconds
    When I expand combobox "Staffing Company"
    Then I wait 10 seconds
    When I select "Therapeutic Touch, Inc." from combobox "Staffing Company"
    Then I wait 10 seconds
    When I press "Ok"
    Then I wait for the response from the server
    And I wait 10 seconds
    When I press close button in window with title "Therapy Re Evaluations"
    Then I wait 5 seconds
