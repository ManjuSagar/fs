Feature: Field Staff Login: Staffing Requests page
  Background:
    Given I visit "signin" page
    And I log in as "fnpublic+roger@gmail.com" and password "test1234"
    When I wait 5 seconds
    Then I press "OK"
    And I wait 10 seconds
    Then I should see "Patients"
    When I go to main menu "field_staff_staffing_request_list" page
    Then I wait 10 seconds

  @javascript
  Scenario: Active Staffing Requests
    When I check ext checkbox "Active"
    And I wait 5 seconds
    And I uncheck ext checkbox "Archive"
    And I wait 5 seconds
    Then I should see the record with field "Status" and value "New" with in grid "field_staff_staffing_request_grid"
    And I wait 10 seconds

  @javascript
  Scenario: Archive Staffing Requests
    When I check ext checkbox "Archive"
    And I wait 5 seconds
    And I uncheck ext checkbox "Active"
    And I wait 5 seconds
    Then I should see the record with field "Status" and value "Cancelled" with in grid "field_staff_staffing_request_grid"
    And I wait 10 seconds

  @javascript
  Scenario: Active and Archive Staffing Requests
    When I check ext checkbox "Active"
    And I wait 5 seconds
    And I check ext checkbox "Archive"
    And I wait 5 seconds
    Then I should see the record with field "Status" and value "New" with in grid "field_staff_staffing_request_grid"
    Then I should see the record with field "Status" and value "Cancelled" with in grid "field_staff_staffing_request_grid"
    And I wait 10 seconds

  @javascript
  Scenario: Interested action for request
    When I check ext checkbox "Active"
    And I wait 5 seconds
    And I uncheck ext checkbox "Archive"
    And I wait 5 seconds
    When I click action "Interested" in the record with field "Status" and value "New" with in grid "field_staff_staffing_request_grid"
    And I wait 5 seconds
    Then I should see the record with field "Status" and value "Expressed Interest" with in grid "field_staff_staffing_request_grid"

  @javascript
  Scenario: Decline action for request
    When I check ext checkbox "Active"
    And I wait 5 seconds
    And I uncheck ext checkbox "Archive"
    And I wait 5 seconds
    When I click action "Decline" in the record with field "Status" and value "New" with in grid "field_staff_staffing_request_grid"
    And I wait 5 seconds
    Then I should see the record with field "Status" and value "Declined" with in grid "field_staff_staffing_request_grid"