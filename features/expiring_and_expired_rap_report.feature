Feature: Expiring RAPs
  Background:
    Given I visit "signin" page
    Given I log in as "fnpublic+zakharyan2@gmail.com" and password "test1234"
    And I wait 5 seconds
    When I press "OK"
    And I wait 10 seconds
    Then I should see "Patients"
    When I go to main menu "reports" page
    And I wait 10 seconds

  @javascript
  Scenario: report
    And I go to "Expiring RAPs" node in "reports" menu
    And I wait 10 seconds
    Then I should see "Expiring RAPs Report"