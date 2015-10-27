When(/^I add treatment physician with in patient chart$/) do
  step %Q{I expand combobox "Physician"}
  step %Q{I wait 3 seconds}
  step %Q{I select "Thomas Ahn, MD" from combobox "Physician"}
  step %Q{I wait 3 seconds}
  step %Q{I check ext checkbox "Primary Physician?"}
  step %Q{I wait 3 seconds}
  step %Q{I check ext checkbox "Require CC?"}
  step %Q{I wait 3 seconds}
  step %Q{I press "Save" within "save"}
  step %Q{I wait 5 seconds}
  step %Q{I press OK}
  step %Q{I wait 5 seconds}
  step %Q{I wait for the response from the server}
end

When(/^I edit treatment physician with in patient chart$/) do
  step %Q{uncheck ext checkbox "Primary Physician?"}
  step %Q{I wait 3 seconds}
  step %Q{I press "Save" within "save"}
  step %Q{I wait 5 seconds}
  step %Q{I press OK}
  step %Q{I wait 5 seconds}
  step %Q{I wait for the response from the server}
end

When(/^I add medication with in patient chart$/) do
  step %Q{I expand combobox "Episode"}
  step %Q{I wait 3 seconds}
  step %Q{I select "02/24/14 - 04/24/14" from combobox "Episode"}
  step %Q{I wait 3 seconds}
  step %Q{I fill in "SARISOL NO. 1 (15MG)" for "Name"}
  step %Q{I wait 3 seconds}
  step %Q{I fill in "1wk2" for "Frequency"}
  step %Q{I wait 3 seconds}
  step %Q{I select "N" from combobox "N/C"}
  step %Q{I wait 3 seconds}
  step %Q{I press "Save" within "medication_form"}
  step %Q{I wait 5 seconds}
  step %Q{I press OK}
  step %Q{I wait 3 seconds}
  step %Q{I wait for the response from the server}
end

When(/^I edit treatment medication with in patient chart$/) do
  step %Q{I fill in "AMLODIPINE BESYLATE AND VALSARTAN (EQ 10MG BASE;320MG)" for "Name"}
  step %Q{I wait 3 seconds}
  step %Q{I fill in "1wk2" for "Frequency"}
  step %Q{I wait 3 seconds}
  step %Q{I select "N" from combobox "N/C"}
  step %Q{I wait 3 seconds}
  step %Q{I fill in "No" for "Potential Side Effects"}
  step %Q{I wait 3 seconds}
  step %Q{I press "Save" within "medication_form"}
  step %Q{I wait 5 seconds}
  step %Q{I press OK}
  step %Q{I wait 3 seconds}
  step %Q{I wait for the response from the server}
end

When(/^I add frequency with in patient chart/) do
  step %Q{I expand combobox "Episode"}
  step %Q{I wait 3 seconds}
  step %Q{I select "02/24/14 - 04/24/14" from combobox "Episode"}
  step %Q{I wait 3 seconds}
  step %Q{I expand combobox "Discipline"}
  step %Q{I wait 3 seconds}
  step %Q{I select "Home Health Aide" from combobox "Discipline"}
  step %Q{I wait 3 seconds}
  step %Q{I fill in "04/02/2014" for "Start Date"}
  step %Q{I wait 3 seconds}
  step %Q{I fill in "1wk1" for "Frequency"}
  step %Q{I wait 3 seconds}
  step %Q{I press "Save"}
  step %Q{I wait 5 seconds}
  step %Q{I press OK}
  step %Q{I wait 3 seconds}
  step %Q{I wait for the response from the server}
end

When(/^I add Visit/) do
  step %Q{I expand combobox "Visited Staff"}
  step %Q{I wait 3 seconds"}
  step %Q{I select "Suzanne Naoumovitch, RN" from combobox "Visited Staff"}
  step %Q{I wait 3 seconds"}
  step %Q{I expand combobox "Visit Type"}
  step %Q{I wait 5 seconds"}
  step %Q{I select "SN - Catheter" from combobox "Visit Type"}
  step %Q{I wait 5 seconds"}
end

When(/^I add Vitals/) do
  step %Q{I fill in "110" for "systolic_bp"}
  step %Q{I wait 3 seconds"}
  step %Q{I fill in "75" for "diastolic_bp"}
  step %Q{I wait 3 seconds"}
  step %Q{I select "Left Arm" from combobox "bp_read_location"}
  step %Q{I wait 3 seconds"}
  step %Q{I select "Sitting" from combobox "bp_read_position"}
  step %Q{I wait 3 seconds"}
  step %Q{I fill in "100" for "heart_rate"}
  step %Q{I wait 3 seconds"}
  step %Q{I fill in "98" for "respiration_rate"}
  step %Q{I wait 3 seconds"}
  step %Q{I fill in "95" for "blood_sugar"}
  step %Q{I wait 3 seconds"}
  step %Q{I select "Fasting" from combobox "sugar_read_period"}
  step %Q{I wait 3 seconds"}
  step %Q{I fill in "120" for "weight_in_lbs"}
  step %Q{I wait 3 seconds"}
  step %Q{I fill in "100" for "temperature_in_fht"}
  step %Q{I wait 3 seconds"}
  step %Q{I fill in "90" for "oxygen_saturation"}
  step %Q{I wait 3 seconds"}
  step %Q{I fill in "80" for "pain"}
  step %Q{I wait 3 seconds"}
  step %Q{I press "Save"}
  step %Q{I wait 5 seconds}
  step %Q{I press OK}
  step %Q{I wait 3 seconds}
end

When(/^I add Treatment Staff with in patient chart$/) do
  step %Q{I expand combobox "Discipline"}
  step %Q{I wait 3 seconds}
  step %Q{I select "Skilled Nursing" from combobox "Discipline"}
  step %Q{I wait 3 seconds}
  step %Q{I expand combobox "Visit Type"}
  step %Q{I wait 3 seconds}
  step %Q{I select "SOC-Eval" from combobox "Visit Type"}
  step %Q{I wait 3 seconds}
  step %Q{I select ext radio "Show all staffs"}
  step %Q{I wait 3 seconds}
  step %Q{I expand combobox "Staff"}
  step %Q{I wait for the response from the server}
  step %Q{I select "Elena Kaminskaya, RN" from combobox "Staff"}
  step %Q{I wait 3 seconds}
  step %Q{I press "Save"}
  step %Q{I wait 5 seconds}
  step %Q{I press OK}
  step %Q{I wait 3 seconds}
  step %Q{I wait for the response from the server}
end

When(/^I edit Treatment Staff with in patient chart$/) do
  step %Q{I expand combobox "Staff"}
  step %Q{I wait for the response from the server}
  step %Q{I select "Lana Gevorkyan, RN" from combobox "Staff"}
  step %Q{I wait 3 seconds}
  step %Q{I press "Save"}
  step %Q{I wait 5 seconds}
  step %Q{I press OK}
  step %Q{I wait 3 seconds}
  step %Q{I wait for the response from the server}
end

When /^(?:|I )add plan of care document with date "([^"]*)"?$/ do |date|
  step %Q{I expand combobox "Field Staff"}
  step %Q{I wait for the response from the server}
  step %Q{I select "Suzanne Naoumovitch, RN" from combobox "Field Staff"}
  step %Q{I wait 3 seconds}
  step %Q{I check ext checkbox "Field Signature Not Required"}
  step %Q{I wait 3 seconds}
  step %Q{I fill in "#{date}" for "POC Date:"}
end
