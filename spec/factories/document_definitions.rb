require 'faker'

FactoryGirl.define do
  factory :document_definition do |f|
    f.document_code 'SOC_OASIS_C1'
    f.document_name 'OASIS Evaluation C1'
    association :document_form_template
    association :org, factory: :health_agency, strategy: :build
  end
end