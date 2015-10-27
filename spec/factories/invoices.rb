require 'faker'

FactoryGirl.define do
  factory :invoice do |i|
    i.invoice_number {Faker::Number.number(2) }
    i.invoice_date "10/10/2013"#{Faker::Date.backward(60) }
    i.org_id 145
    i.payer_type "InsuranceCompany"
    i.payer_id  68
    i.invoice_amount 200.00
    i.invoice_status "D"
    i.invoice_type "327"
    association :treatment, factory: :patient_treatment, strategy: :build
  end


end