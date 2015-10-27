Feature: Field Staff Menu Testing
  Background:
    Given I visit "signin" page
    Given I log in as "fnpublic+steffi@gmail.com" and password "test1234"
    When I wait 5 seconds
    When I press "OK"
    When I wait 10 seconds
    Then I should see "Patients"

  @javascript
  Scenario: View Health Agencies
    When I go to main menu "field_staff_agencies_info" page
    When I wait 5 seconds
    Then I should see "Agencies"
    When I wait 5 seconds








