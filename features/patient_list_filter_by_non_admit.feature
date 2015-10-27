Feature: Patient List Filter By Non Admit
  Background:
    Given I visit "signin" page
    Given I log in as "info@mymetrohc.com" and password "test1234"
    When I wait 5 seconds
    When I press "OK"
    When I wait 10 seconds
    Then I should see "Patients"

  @javascript
  Scenario: Patient list filter Non admit (NA)
    When I check ext checkbox with id "NA"
    Then I wait 10 seconds