Feature: Patient List Action Links
  Background:
    Given I visit "signin" page
    Given I log in as "info@mymetrohc.com" and password "test1234"
    When I wait 5 seconds
    When I press "OK"
    When I wait 10 seconds
    Then I should see "Patients"

  @javascript
  Scenario: Recertify Patient

  @javascript
  Scenario: Discharge Patient

  @javascript
  Scenario: Hold Patient

