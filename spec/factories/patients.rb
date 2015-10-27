require 'faker'

FactoryGirl.define do
  factory :patient do |f|
    f.first_name {Faker::Name.first_name}
    f.last_name {Faker::Name.last_name}
    f.dob "05/02/1975"
    f.gender "Male"
    f.ssn "897-97-9877"
    f.medicare_number "897979877A"
    f.street_address {Faker::Address.street_address}
    f.suite_number "234"
    f.zip_code {Faker::Address.zip_code}
    f.city {Faker::Address.city}
    f.state {Faker::Address.state}
    f.phone_number "(986) 899-7889"
    f.phone_number_2  "(878) 678-8898"
    #f.org Org.find(145)
    association :org, factory: :health_agency, strategy: :build
  end
end