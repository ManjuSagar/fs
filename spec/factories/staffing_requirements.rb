require 'faker'

FactoryGirl.define do
  factory :staffing_requirement do |f|
    association :staffing_master, strategy: :build
  end

end