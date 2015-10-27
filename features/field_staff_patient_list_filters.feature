Feature: HHA Associated Field Staff List
  Background:
    Given I visit "signin" page
    And I log in as "fnpublic+steffi@gmail.com" and password "test1234"
    When I wait 5 seconds
    Then I press "OK"
    And I wait 10 seconds
    Then I should see "Patients"
    When I uncheck ext checkbox "PE"
    And I uncheck ext checkbox "AC"
    Then I wait 10 seconds

  @javascript
  Scenario: Patient list filter Pending Evaluation (PE)
    When I check ext checkbox "PE"
    Then I wait 10 seconds

  @javascript
  Scenario: Patient list filter Active (AC)
    When I check ext checkbox "AC"
    Then I wait 10 seconds

  @javascript
  Scenario: Patient list filter Hold (HD)
    When I check ext checkbox "HD"
    Then I wait 10 seconds

  @javascript
  Scenario: Patient list filter Discharge (DC)
    When I check ext checkbox "DC"
    Then I wait 10 seconds

  @javascript
  Scenario: Patient list filters Hold (HD) and Discharge (DC)
    When I check ext checkbox "DC"
    And I check ext checkbox "HD"
    Then I wait 10 seconds

  @javascript
  Scenario: Patient list filters Pending Evaluation (PE) and Hold (HD)
    When I check ext checkbox "PE"
    And I check ext checkbox "HD"
    Then I wait 10 seconds

  @javascript
  Scenario: Patient list filters Pending Evaluation (PE) and Discharge (DC)
    When I check ext checkbox "PE"
    And I check ext checkbox "DC"
    Then I wait 10 seconds

  @javascript
  Scenario: Patient list filters Active (PE) and Discharge (DC)
    When I check ext checkbox "AC"
    And I check ext checkbox "DC"
    Then I wait 10 seconds

  @javascript
  Scenario: Patient list filters Active (PE) and Hold (HD)
    When I check ext checkbox "AC"
    And I check ext checkbox "HD"
    Then I wait 10 seconds