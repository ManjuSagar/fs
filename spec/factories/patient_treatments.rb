require 'faker'

FactoryGirl.define do
  factory :patient_treatment do |i|
    association :treatment_request, strategy: :build
    association :patient, strategy: :build
    i.treatment_start_date  "07/10/2013"
  end


end