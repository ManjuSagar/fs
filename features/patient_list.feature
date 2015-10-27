Feature: Patient List
  Background:
    Given I visit "signin" page
    Given I log in as "info@mymetrohc.com" and password "test1234"
    When I wait 5 seconds
    When I press "OK"
    When I wait 10 seconds
    Then I should see "Patients"

  @javascript
  Scenario: Add Patient
    When I press with id "add_patient_button"
    Then I wait 5 seconds
#    When I add a patient "James1 Smith1"
    When I fill in "Name:*" with "Sample"
    Then I wait 3 seconds
    When I fill in "Patient" for "Last Name"
    Then I wait 3 seconds
    When I fill in "02/11/1945" for "DOB(mm/dd/yyyy)"
    When I select "Male" from combobox "gender"
    When I fill in Ext field "ssn" with "123456789"
    When I fill in Ext field "medicare_number" with "123456789A"
    When I fill in Ext field "street_address" with "30960 Via La Cresta"
    When I fill in Ext field "Location" with "90024"
    Then I wait 5 seconds
    When I fill in Ext field "phone_number" with "9003290032"
    When I press "Add Insurance Company" within "medicare_eligibility"
    Then I wait 5 seconds
    When I expand combobox "Name"
    When I select "Medicare Health Insurance" from combobox "Name"
    Then I wait 5 seconds
    When I fill in "02/11/2012" for "Effective Date"
    Then I wait 3 seconds
    When I press "Save" within "pat_ins_comp_add_form"
    Then I wait 3 seconds
    When I press OK
    Then I wait for the response from the server
    Then the grid "patient_insurance_companies_list" should show 1 records
    Then I wait 3 seconds
    Then I wait 3 seconds
    Then I wait 5 seconds
    When I press "Save" within "medicare_eligibility"
    Then I wait 5 seconds
    Then I wait 5 seconds
    When I press "Yes"
    Then I wait for the response from the server
    When I expand combobox "Referring Physician"
    Then I wait for the response from the server
    When I select "Adam Adamson, MD" from combobox "Referring Physician"
    When I expand combobox "Primary Insurance Company"
    Then I wait for the response from the server
    When I select "Medicare Health Insurance (MEDICARE)" from combobox "Primary Insurance Company"
    And I check ext checkbox "SN"
    Then I wait 3 seconds
    When I check ext checkbox "PT"
    Then I wait 3 seconds
    When I check ext checkbox "Referral Received"
    Then I wait 3 seconds
    When I expand combobox "Point Of Origin"
    Then I wait for the response from the server
    When I select "1 - Physician Referral" from combobox "Point Of Origin"
    When I press "Save" within "referral_new_form"
    Then I wait 3 seconds
    When I press "Yes"
    Then I wait 60 seconds
    When I press "Add" within "treatment_request_staff_grid"
    Then I wait for the response from the server
    When I expand combobox "Discipline"
    Then I wait for the response from the server
    When I select "SN" from combobox "Discipline"
    When I select ext radio "Show all staffs"
    Then I wait for the response from the server
    When I expand combobox "Staff"
    Then I wait for the response from the server
    When I select "Suzanne Naoumovitch, RN" from combobox "Staff"
    Then I wait 3 seconds
    When I press "Save" within "request_staff_add_form"
    Then I wait 3 seconds
    When I press OK
    Then I wait for the response from the server
    When I wait 5 seconds
  #step %Q{I add referral staff "Therapeutic Touch, Inc." for discipline "PT"}
    When I press "Add" within "treatment_request_staff_grid"
    Then I wait for the response from the server
    When I expand combobox "Discipline"
    Then I wait for the response from the server
    When I select "PT" from combobox "Discipline"
    When I select ext radio "Show all staffs"
    Then I wait for the response from the server
    When I expand combobox "Staff"
    Then I wait for the response from the server
    When I select "Therapeutic Touch, Inc." from combobox "Staff"
    Then I wait 3 seconds
    When I press "Save" within "request_staff_add_form"
    Then I wait 3 seconds
    When I press OK
    Then I wait for the response from the server
    And I wait 5 seconds
    Then I wait 5 seconds
    When I press close button in window with title "Staffing"
    Then I wait for the response from the server
    Then I should see "Patient"
    And I wait 10 seconds

  @javascript
  Scenario: Medicare eligibility primary validation
    When I press with id "add_patient_button"
    Then I wait 5 seconds
    When I fill in "Name:*" with "Sample"
    Then I wait 3 seconds
    When I fill in "" for "Last Name"
    Then I wait 3 seconds
    When I fill in "" for "DOB(mm/dd/yyyy)"
    When I select "Male" from combobox "gender"
    When I fill in Ext field "ssn" with "123456789"
    When I press "Medicare Eligibility" within "medicare_eligibility"
    When I wait 10 seconds
    Then I should see "can't be blank"


  @javascript
  Scenario: Add Insurance Company

  @javascript
  Scenario: Add Referral

  @javascript
  Scenario: Add Staffing