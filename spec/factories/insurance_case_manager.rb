require 'faker'

FactoryGirl.define do
  factory :insurance_case_manager do |i|
    i.first_name Faker::Name.first_name
    i.last_name Faker::Name.last_name
    i.phone_number Faker::PhoneNumber
    i.email 'fasternotes@gmail.com'
    association :insurance_company, factory: :insurance_company, strategy: :build
  end
end
