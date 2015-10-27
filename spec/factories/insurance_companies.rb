require 'faker'

FactoryGirl.define do
  factory :insurance_company do |f|
    f.company_name {Faker::Name.first_name}
    f.company_code {Faker::Name.last_name}
    f.claim_street_address {Faker::Address.street_address}
    f.claim_suite_number "234"
    f.claim_zip_code '90013'
    f.claim_city {Faker::Address.city}
    f.claim_state 'MD'
    f.claim_phone_number "(986) 899-7889"
    f.org Org.find(145)
    f.claim_submission_due_days 30
  end
end