require 'faker'

FactoryGirl.define do
  factory :health_agency do |f|
    f.org_name { "#{Faker::Company.name} Health Care Inc." }
    f.id Faker::Number.number(3)
    f.org_package "F"
    f.week_start_day 'MON'
    f.suite_number "123"
    f.street_address "123 Main St."
    f.city "Los Angeles"
    f.state "CA"
    f.zip_code "90025"
    f.zip_code_part2 "1234"
    f.email { "#{Faker::Name.first_name}_#{Faker::Name.last_name}@gmail.com" }
    f.preferred_alert_mode 'E'
    f.phone_number "(310) 752-1234"
    f.fax_number "(310) 752-1234"
    f.fed_tax_number "351593574"
    f.primary_contact_first_name {"#{Faker::Name.first_name}"}
    f.primary_contact_last_name {"#{Faker::Name.last_name}"}
    f.primary_contact_phone_number {"#{Faker::PhoneNumber.numerify('(###)###-####')}"}
    f.primary_contact_extension {"#{Faker::PhoneNumber.extension}"}
    f.primary_contact_email  {"#{Faker::Name.first_name}_#{Faker::Name.last_name}@gmail.com"}
    f.primary_contact_password "test1234"
    f.primary_contact_password_confirmation "test1234"

    after(:create) do |agency|
      create(:attachment_type, agency: agency)
    end
  end
end