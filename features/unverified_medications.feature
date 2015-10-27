Feature: Unverified Medications
  Background:
    Given I visit "signin" page
    Given I log in as "fnpublic+zakharyan2@gmail.com" and password "test1234"
    And I wait 5 seconds
    When I press "OK"
    And I wait 10 seconds
    Then I should see "Patients"
    When I go to main menu "reports" page
    And I wait 10 seconds
    And I go to "Unverified Medications" node in "reports" menu
    And I wait 10 seconds

  @javascript
  Scenario: MD filter
    When I expand combobox "MD"
    Then I wait 5 seconds
    When I select "Mark Barats, MD" from combobox "MD"
    And I wait 5 seconds
    And I press "Ok"
    And I wait 5 seconds
    And I wait for the response from the server
    And I press close button in window with title "Unverified Medications Report"
    And I wait 5 seconds

  @javascript
  Scenario: Field Staff filter
    When I select ext radio "Field Staff"
    And I wait 5 seconds
    When I expand combobox "Field Staff"
    Then I wait 5 seconds
    When I select "Suzanne Naoumovitch, RN" from combobox "Field Staff"
    And I wait 5 seconds
    And I press "Ok"
    And I wait 5 seconds
    And I wait for the response from the server
    And I press close button in window with title "Unverified Medications Report"
    And I wait 5 seconds

  @javascript
  Scenario: Patient filter
    When I select ext radio "Patient"
    And I wait 5 seconds
    When I expand combobox "Patient"
    Then I wait 5 seconds
    When I select "Carlotta Brademan" from combobox "Patient"
    And I wait 5 seconds
    And I press "Ok"
    And I wait 5 seconds
    And I wait for the response from the server
    And I press close button in window with title "Unverified Medications Report"
    And I wait 5 seconds

  @javascript
  Scenario: No Records Found