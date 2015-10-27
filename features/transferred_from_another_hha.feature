Feature: Transfer from another HHA
  Background:
    Given I visit "signin" page
    Given I log in as "info@mymetrohc.com" and password "515253tt"
    When I wait 5 seconds
    When I press "OK"
    When I wait 10 seconds
    Then I should see "Patients"

  @javascript
  Scenario: Patient Information
    When I open chart with patient name "George Alexander" with episode "03/03/14 - 05/01/14"
    When I wait 5 seconds
    Then I should see "Patient Profile"
    When I wait 5 seconds
    Then I should see "Chart"
    And I wait 5 seconds
    When I go to "Referral" node
    Then I wait 10 seconds
    When I check ext checkbox "Transferred from Another HHA"
    Then I wait 5 seconds
    When I press "Apply"
    Then I wait 5 seconds
    When I press "OK"
    When I go to "Billing" node
    Then I wait 10 seconds
    When I select row 1 of the grid with id "invoice_list_grid"
    Then I wait 3 seconds
    When I press "Print Invoice"
    Then I wait 20 seconds
    When I press close button in window with id "print_invoice"
    Then I wait 5 seconds





