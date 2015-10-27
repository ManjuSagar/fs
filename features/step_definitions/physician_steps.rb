When /^(?:|I )add a physician "([^"]*)"?$/ do |name|
  first_name, last_name = name.split(" ")
  step %Q{I fill in "Name:*" with "#{first_name}"}
  step %Q{I wait 3 seconds}
  step %Q{I fill in "#{last_name}" for "Last Name"}
  step %Q{I wait 3 seconds}
  step %Q{I fill in "2080 Century Park East" for "Street Address"}
  step %Q{I wait 3 seconds}
  step %Q{I fill in "1231" for "Suite #"}
  step %Q{I wait 3 seconds}
  step %Q{I fill in "90013" for "ZIP Code"}
  step %Q{I wait 3 seconds}
  step %Q{I fill in "Los Angeles" for "City"}
  step %Q{I wait 3 seconds}
  step %Q{I fill in "California" for "State"}
  step %Q{I wait 3 seconds}
  step %Q{I fill in "NPI/Phone/Fax:*" with "1111111111"}
  step %Q{I wait 5 seconds}
  step %Q{I fill in "(999) 999-9999" for "Phone Number"}
  step %Q{I wait 5 seconds}
  step %Q{I fill in "(999) 999-9999" for "Fax Number"}
  step %Q{I wait 3 seconds}
  step %Q{I fill in "sample1@gmail.com" for "MO Recipient Email"}
  step %Q{I wait 3 seconds}
  step %Q{I fill in "(999) 999-9999" for "Pvt Phone 1"}
  step %Q{I wait 3 seconds}
  step %Q{I fill in "(999) 999-9999" for "Pvt Phone 2"}
  step %Q{I wait 3 seconds}
  step %Q{I press "Save" within "save"}
  step %Q{I wait 5 seconds}
  step %Q{I press OK}
  step %Q{I wait 3 seconds}
  step %Q{I wait for the response from the server}
end


