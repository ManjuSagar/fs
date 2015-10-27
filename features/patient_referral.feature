Feature: Transfer from another HHA
  Background:
    Given I visit "signin" page
    Given I log in as "info@mymetrohc.com" and password "515253tt"
    When I wait 5 seconds
    When I press "OK"
    When I wait 10 seconds
    Then I should see "Patients"

  @javascript
  Scenario: View the alignment of language mandatory, special instructions in referral
    When I press with id "add_referral_button"
    Then I wait 5 seconds
    When I scroll down with id "referral_new_form"
    Then I wait 10 seconds
    Then I should see "Language Mandatory"

