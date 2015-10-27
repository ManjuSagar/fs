require 'faker'

FactoryGirl.define do
  factory :treatment_episode do |f|
    f.start_date '01/02/2015'
    f.end_date '03/05/2015'
    f.episode_status ''
    association :treatment, factory: :patient_treatment, strategy: :build
  end
end