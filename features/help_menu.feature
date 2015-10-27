Feature: Help Menu
  Background:
    Given I visit "signin" page
    And I sleep 3 seconds

  @javascript
  Scenario: Office Staff Login help
    Given I log in as "info@mymetrohc.com" and password "515253tt"
    When I sleep 5 seconds
    Then I press "OK"
    And I sleep 10 seconds
    Then I should see "Patients"
    When I follow "Help"
    And I sleep 10 seconds

  @javascript
  Scenario: Field Staff Login help
    Given I log in as "fnpublic+steffi@gmail.com" and password "test1234"
    When I sleep 5 seconds
    Then I press "OK"
    And I sleep 10 seconds
    Then I should see "Patients"
    When I follow "Help"
    And I sleep 10 seconds