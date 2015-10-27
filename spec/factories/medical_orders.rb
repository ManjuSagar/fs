require 'faker'

FactoryGirl.define do
  factory :medical_order do |f|
    #association :treatment_episode, strategy: :build
    #association :order_type, strategy: :build
    #association :physician, strategy: :build
    #association :created_user, factory: :user, startegy: :build
    #association :treatment, factory: :patient_treatment, strategy: :build
    f.order_status "D"
    f.order_date Date.current
    f.order_reference '2345'

  end
end