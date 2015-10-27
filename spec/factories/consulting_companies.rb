require 'faker'

FactoryGirl.define do
  factory :consulting_company do |f|
    f.org_name { "#{Faker::Company.name} Health Care Inc." }
    f.org_package "F"
    f.week_start_day 'MON'
    f.suite_number "123"
    f.street_address "123 Main St."
    f.city "Los Angeles"
    f.state "CA"
    f.zip_code "90025"
    f.email { "#{Faker::Name.first_name}_#{Faker::Name.last_name}@gmail.com" }
    f.preferred_alert_mode 'E'
    f.phone_number "(310) 752-1234"
    f.fax_number "(310) 752-1234"
    f.fed_tax_number "351593574"
  end
end