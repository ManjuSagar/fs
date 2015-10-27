Feature: Patient Chart Testing
  Background:
    Given I visit "signin" page
    Given I log in as "info@mymetrohc.com" and password "test1234"
    When I wait 5 seconds
    When I press "OK"
    When I wait 10 seconds
    Then I should see "Patients"

  @javascript
  Scenario: Patient Information
    When I open chart with patient name "James Smith" with episode "02/24/14 - 04/24/14"
    When I wait 5 seconds
    Then I should see "Patient Profile"
    When I wait 5 seconds
    Then I should see "Chart"
    When I wait 5 seconds
    When I go to "Patient Information" node
    Then I wait 5 seconds
    Then I should see "Medicare Eligibility"
    When I press with id "medicare_eligibility_button"
    When I wait 30 seconds
    When I press close button in window with title "Eligibility Check Report"
    Then I wait 5 seconds

