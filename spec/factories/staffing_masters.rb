require 'faker'

FactoryGirl.define do
  factory :staffing_master do |f|
    association :staffable, factory: :patient_treatment, strategy: :build
    f.created_date_time Time.now
  end

end