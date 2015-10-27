Feature: Patient Chart Referral Staff Screen Test
  Background:
    Given I visit "signin" page
    Given I log in as "info@mymetrohc.com" and password "test1234"
    When I wait 5 seconds
    When I press "OK"
    When I wait 10 seconds
    Then I should see "Patients"
    When I open chart with patient name "Norista Arutyunyan" with episode "03/12/14 - 05/10/14"
    When I wait 5 seconds
    Then I should see "Patient Profile"
    When I wait 5 seconds
    Then I should see "Chart"
    When I wait 5 seconds
    When I go to "Staffing" node within like "SOC 03/12/2014"
    Then I wait 15 seconds

  @javascript
  Scenario: Add Referral requirement

  @javascript
  Scenario: Edit Referral requirement

  @javascript
  Scenario: Delete Referral requirement

  @javascript
  Scenario: Broadcast Referral requirements
    When I press with id "broadcast_button"