When /^I add Insurance Company "([^"]*)"?$/ do |name|
  company_name = name
  step %Q{I fill in "Name" with "#{company_name}"}
  step %Q{I fill in "Code" with "AXA"}
  step %Q{I fill in "Address" with "West Wood Street"}
  step %Q{I fill in "Suite #" with "123"}
  step %Q{I fill in "ZIP Code" with "90012"}
  step %Q{I fill in "City" with "Los Angeles"}
  step %Q{I fill in "State" with "CA"}
  step %Q{I press "Save" within "add_ins_cmpny"}
  step %Q{I wait 5 seconds}
  step %Q{I press OK}
  step %Q{I wait for the response from the server}
  step %Q{I wait 5 seconds}
end
