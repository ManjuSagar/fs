require 'faker'

FactoryGirl.define do
  factory :private_receivable do |i|
    i.payer_type "InsuranceCompany"
    i.source_type "TreatmentVisit"
    i.purpose "Skilled Nursing"
    i.receivable_date "10/10/2013"
    i.receivable_amount 200.12
    i.receivable_type "V"
    i.hcpcs_code "G0163"
    i.revenue_code "G9999"
    i.service_units 3
    i.due_date "2013-04-26"
    i.received_amount 123.23
    i.treatment_id {[FactoryGirl.build(:patient_treatment)]}
    i.treatment_episode_id {[FactoryGirl.build(:treatment_episode)]}
  end
end
