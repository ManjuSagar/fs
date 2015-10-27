require 'faker'

FactoryGirl.define do
  factory :field_staff do |f|
    association :license_type, strategy: :build
    f.first_name { Faker::Name.first_name }
    f.last_name { Faker::Name.last_name }
    f.email { "#{Faker::Name.first_name}_#{Faker::Name.last_name}@gmail.com" }
    f.password "test1234"
    f.password_confirmation "test1234"
    f.suite_number "123"
    f.street_address "123 Main St."
    f.city "Los Angeles"
    f.state "CA"
    f.zip_code "90013"
    f.phone_number "(310) 752-1234"
    f.approved true
    f.gender 'M'
  end
end