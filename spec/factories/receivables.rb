require 'faker'

FactoryGirl.define do
  factory :receivable do |i|
    i.receivable_date "10/10/2013"
    i.org_id 145
    i.payer_type "InsuranceCompany"
    i.payer_id  68
    i.receivable_amount 200.12
    i.service_units 1
  end


end