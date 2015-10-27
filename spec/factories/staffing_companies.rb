require 'faker'

FactoryGirl.define do
  factory :staffing_company do |f|
    f.org_name { "#{Faker::Company.name} Home Therapy." }
    f.org_type "StaffingCompany"
    f.week_start_day 'MON'
    f.suite_number "123"
    f.street_address "126 S. Jackson St."
    f.city "Los Angeles"
    f.state "CA"
    f.zip_code "90025"
    f.email { "#{Faker::Name.first_name}_#{Faker::Name.last_name}@gmail.com" }
    f.preferred_alert_mode 'E'
    f.phone_number "(310) 752-98989"
    f.fax_number "(310) 752-27677"
    f.fed_tax_number "988789878"
  end
end



