require "faker"

FactoryGirl.define do
  factory :authorization_tracking do |i|
    i.patient_number Faker::Number
    i.discipline_id 30
    i.visit_count 4
    i.start_date Date.current
    i.end_date Date.current + 10
    i.authorization_number 30
    i.special_instructions Faker::Lorem.sentence
    i.internal_comments Faker::Lorem.sentence
    i.reported false
    i.evaluation_sent false
    i.approval_received false
    i.visit_done false
    association :patient, factory: :patient, strategy: :build
    association :treatment_episode, factory: :treatment_episode, strategy: :build
    association :insurance_company, factory: :insurance_company, strategy: :build
    association :field_staff, factory: :field_staff,strategy: :build
    association :insurance_case_manager, factory: :insurance_case_manager, strategy: :build
  end
end