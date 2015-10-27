require 'faker'
FactoryGirl.define do
  factory :visit_type do
    association :discipline, strategy: :build
    visit_type_code "PT_EVAL"
    visit_type_description "Evaluation"
    visit_type_status "A"
  end
end