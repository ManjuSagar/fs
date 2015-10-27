Feature:

In order to [Business Value]
As a [Role]
I want to [Some Action] (feature) 

@javascript
Scenario: Add patient information
  Given I visit "signin" page
  Given I log in as "info@mymetrohc.com" and password "515253tt"
  When I wait 5 seconds
  When I press "OK"
  When I wait 10 seconds
  Then I should see "Patients"
  #When I go to main menu "oasis_documents" page
  #When I press with id "add_patient_button"
  #When I add a patient "James Smith"
  #When I open chart with patient name "Raquel Garcia"
  #When I open chart with patient name "Yuli Barsky" with disciplines "SN:PT"
  #When I open chart with patient name "James Smith" with episode "02/24/14 - 04/24/14"
  #When I wait 10 seconds
  #When I go to "Patient Information" node
  #When I wait 10 seconds
  #When I go to "Referral" node within like "SOC 04/30/2013"
  #hen I wait 10 seconds
  #When I go to "Physicians" node within like "SOC 04/30/2013"
  #When I wait 10 seconds
  #Given I visit "signout" page
  #When I wait 5 seconds

@javascript
Scenario: Add Insurance Company Information
  Given I visit "signin" page
  Given I log in as "info@mymetrohc.com" and password "515253tt"
  When I wait 5 seconds
  When I press "OK"
  When I wait 5 seconds
  When I go to main menu "insurance_company" page
  When I wait 10 seconds
  When I press with id "add_ins_compny_button"
  When I wait 5 seconds
  When I add Insurance Company "MET LIFE"
  When I wait 5 seconds

 @javascript
 Scenario: Add Physician information
   Given I visit "signin" page
   Given I log in as "info@mymetrohc.com" and password "test1234"
   When I wait 5 seconds
   When I press "OK"
   When I wait 10 seconds
   Then I should see "Patients"
   When I go to main menu "physician" page
   When I wait 5 seconds
   When I press with id "add_physician_button"
   When I wait 5 seconds
   When I add a physician "Sample Physician"
    #When I open chart with patient name "Raquel Garcia"
    #When I open chart with patient name "Yuli Barsky" with disciplines "SN:PT"
    #When I open chart with patient name "James Smith" with episode "02/24/14 - 04/24/14"
   When I wait 10 seconds