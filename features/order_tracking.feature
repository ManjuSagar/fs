Feature: Order Tracking
  Background:
    Given I visit "signin" page
    Given I log in as "info@mymetrohc.com" and password "515253tt"
    When I wait 5 seconds
    When I press "OK"
    When I wait 10 seconds
    Then I should see "Patients"

  @javascript
  Scenario: View category filter in orders
    When I go to main menu "order_tracking" page
    Then I wait 20 seconds
    When I filter column "Category" within "order_tracking_grid"
    And I wait 10 seconds

  @javascript
  Scenario: Batch print of medical orders
     When I go to main menu "order_tracking" page
     Then I wait 10 seconds
     When I select the range from 0 to 2 within "order_tracking_grid"
     And I wait 20 seconds
     When I press "Print orders"
     Then I wait 20 seconds
     When I press close button in window with id "print_orders"
     Then I wait 5 seconds

  @javascript
  Scenario: Batch print of email orders
    When I go to main menu "order_tracking" page
    Then I wait 10 seconds
    When I select the range from 0 to 2 within "order_tracking_grid"
    And I wait 20 seconds
    When I press "Email orders to Physician"
    Then I wait 20 seconds

  @javascript
  Scenario: Batch print of download orders
    When I go to main menu "order_tracking" page
    Then I wait 10 seconds
    When I select the range from 0 to 2 within "order_tracking_grid"
    And I wait 20 seconds
    When I press "Download orders"
    Then I wait 20 seconds
