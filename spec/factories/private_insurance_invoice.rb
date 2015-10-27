require "faker"

FactoryGirl.define do
  factory :private_insurance_invoice do |i|
    i.invoice_number Faker::Number.number(3)
    i.invoice_date "2015-05-07"
    i.payer_type "InsuranceCompany"
    i.payer_id InsuranceCompany.last.id
    i.invoice_amount 123.00
    i.invoice_type 322
    i.invoice_description "Home Health Services"
    i.treatment_id {[FactoryGirl.build(:patient_treatment)]}
    i.treatment_episode_id {[FactoryGirl.build(:treatment_episode)]}
  end
end
