Feature: Patient List Filter By Column Header
  Background:
    Given I visit "signin" page
    Given I log in as "info@mymetrohc.com" and password "test1234"
    When I wait 5 seconds
    When I press "OK"
    When I wait 10 seconds
    Then I should see "Patients"

  @javascript
  Scenario: Patient List filter by MR #
    When I filter column "MR" with value "30" within "episodes_list"
    And I wait 10 seconds

  @javascript
  Scenario: Patient List filter by Patient Name
    When I filter column "Patient" with value "George" within "episodes_list"
    And I wait 10 seconds

  @javascript
  Scenario: Patient List filter by Episdoe
    When I filter column "Episode" with value "03/03/2014" within "episodes_list"
    And I wait 10 seconds

  @javascript
  Scenario: Patient List filter by SOC
    When I filter column "SOC" with value "03/03/2014" within "episodes_list"
    And I wait 10 seconds

  @javascript
  Scenario: Patient List filter by Status
   When I filter column "Status" with value "AC" within "episodes_list"
   And I wait 10 seconds
   Then I should see "Active" patients list in 'episodes_list'

  @javascript
  Scenario: Patient List filter by Disciplines
    When I filter column "Disciplines" with value "SN" within "episodes_list"
    And I wait 10 seconds

  @javascript
  Scenario: Patient List filter by Eligibility
    When I filter column "Eligibility" with value "right" within "episodes_list"
    And I wait 10 seconds

  @javascript
  Scenario: Patient List filter by Staffed

  @javascript
  Scenario: Patient List filter by Referral

  @javascript
  Scenario: Patient List filter by OASIS
    When I filter column "OASIS" with value "right" within "episodes_list"
    And I wait 10 seconds

  @javascript
  Scenario: Patient List filter by POC

  @javascript
  Scenario: Patient List filter by RAP

  @javascript
  Scenario: Patient List filter by Docs

  @javascript
  Scenario: Patient List filter by Orders

  @javascript
  Scenario: Patient List filter by DC/RC

  @javascript
  Scenario: Patient List filter by FC
