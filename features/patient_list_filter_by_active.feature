Feature: Patient List Filter By Active

  @javascript
  Scenario: Patient list filter Active (AC)
    When I check ext checkbox with id "AC"
    And I wait 10 seconds
    Then I should see "AC" value in "Status" column with grid id "abc"
