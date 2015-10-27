Feature: Patient Chart Visits
  Background:
    Given I visit "signin" page
    Given I log in as "info@mymetrohc.com" and password "test1234"
    When I wait 5 seconds
    When I press "OK"
    When I wait 10 seconds
    Then I should see "Patients"
    When I open chart with patient name "James Smith" with episode "02/24/14 - 04/24/14"
    When I wait 5 seconds
    Then I should see "Patient Profile"
    When I wait 5 seconds
    Then I should see "Chart"
    When I wait 5 seconds
    When I go to "Visits" node within like "Cert 02/24/14"
    Then I wait 5 seconds

  @javascript
  Scenario: Patient Visits
    Then I press with id "add_visit_button"
    Then I wait 5 seconds
#    When I add Visit
    When I expand combobox "Visited Staff"
    Then I wait 3 seconds"
    When I select "Suzanne Naoumovitch, RN" from combobox "Visited Staff"
    Then I wait 3 seconds"
    When I expand combobox "Visit Type"
    Then I wait 5 seconds"
    When I select "SN - Catheter" from combobox "Visit Type"
    Then I wait 5 seconds
#    When I add Vitals
    When I fill in "110" for "systolic_bp"
    Then I wait 3 seconds"
    When I fill in "75" for "diastolic_bp"
    Then I wait 3 seconds"
    When I select "Left Arm" from combobox "bp_read_location"
    Then I wait 3 seconds"
    When I select "Sitting" from combobox "bp_read_position"
    Then I wait 3 seconds"
    When I fill in "100" for "heart_rate"
    Then I wait 3 seconds"
    When I fill in "98" for "respiration_rate"
    Then I wait 3 seconds"
    When I fill in "95" for "blood_sugar"
    Then I wait 3 seconds
    When I select "Fasting" from combobox "sugar_read_period"
    Then I wait 3 seconds"
    When I fill in "120" for "weight_in_lbs"
    Then I wait 3 seconds"
    When I fill in "100" for "temperature_in_fht"
    Then I wait 3 seconds"
    When I fill in "90" for "oxygen_saturation"
    Then I wait 3 seconds"
    When I fill in "80" for "pain"
    Then I wait 3 seconds"
    When I press "Save"
    Then I wait 5 seconds
    When I press OK
    Then I wait 3 seconds
    Then I wait 5 seconds
