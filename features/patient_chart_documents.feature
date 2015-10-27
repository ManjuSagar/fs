Feature: Patient Chart Testing
  Background:
    Given I visit "signin" page
    Given I log in as "info@mymetrohc.com" and password "test1234"
    When I wait 5 seconds
    When I press "OK"
    When I wait 10 seconds
    Then I should see "Patients"
    Then I wait 10 seconds
    When I check ext checkbox with id "DC"
    Then I wait 15 seconds
    When I filter column "Patient" with value "James" within "episodes_list"
    Then I wait 10 seconds
    When I open chart with patient name "James Smith" with episode "02/24/14 - 04/24/14"
    When I wait 10 seconds
    Then I should see "Patient Profile"
    When I wait 5 seconds
    Then I should see "Chart"
    When I wait 5 seconds
    When I go to "Documents" node within like "02/24/14 - 04/24/14"
    Then I wait 10 seconds

  @javascript
  Scenario: Add Document
    When I click on "Add CHHA Evaluation"
    Then I wait 10 seconds
    When I expand combobox "field_staff_id"
    When I select "Suzanne Naoumovitch, RN" from combobox "field_staff_id"
    When I press "Save"
    And I wait 5 seconds
    And I press OK
    And I wait 10 seconds
    Then I should see "CHHA" value in "Category" column with grid id "all_documents"

  @javascript
  Scenario: Edit Document

  @javascript
  Scenario: Add Attachment

  @javascript
  Scenario: Print Document
    When I select row 3 of the grid with id "all_documents"
    Then I wait 3 seconds
    When I press "Print Document"
    Then I wait 10 seconds
    When I press close button in window with id "print_document"
    Then I wait 5 seconds

  @javascript
  Scenario: Delete Document
    When I select row 1 of the grid with id "all_documents"
    When I press "Delete Document"
    Then I wait 5 seconds
    When I press "Yes"
    Then I wait 10 seconds
    And I wait 10 seconds