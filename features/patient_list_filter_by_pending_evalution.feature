Feature: Patient List Filter By Pending Evaluation
  Background:
    Given I visit "signin" page
    Given I log in as "info@mymetrohc.com" and password "test1234"
    When I wait 5 seconds
    When I press "OK"
    When I wait 10 seconds
    Then I should see "Patients"

  @javascript
  Scenario: Patient list filter by pending evaluation (PE)
    When I check ext checkbox with id "PE"
    Then I wait 10 seconds