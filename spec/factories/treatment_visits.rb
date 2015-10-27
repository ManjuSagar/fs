require 'faker'

FactoryGirl.define do
  factory :treatment_visit do |i|
    association :treatment, factory: :patient_treatment, strategy: :build
    association :treatment_episode, strategy: :build
    association :visited_staff, factory: :staffing_company, strategy: :build
    association :visited_user, factory: :field_staff, strategy: :build
    association :discipline, strategy: :build
    association :visit_type, strategy: :build
    i.visit_status 'D'
    i.visited_staff_type 'Org'
    i.visit_entry_type 'E'
  end

end