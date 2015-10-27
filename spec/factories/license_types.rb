require 'faker'

FactoryGirl.define do
  factory :license_type do |i|
    association :discipline, strategy: :build
    i.license_type_code 'PT'
    i.license_type_description "Physical Therapist"
    i.independent_flag TRUE
  end
end