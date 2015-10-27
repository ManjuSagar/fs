require 'faker'
FactoryGirl.define do |f|
  factory :visit_frequency do
    association :treatment, factory: :patient_treatment, strategy: :build
    association :treatment_episode, strategy: :build
    association :discipline, strategy: :build
  end
end