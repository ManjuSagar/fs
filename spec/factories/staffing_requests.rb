require 'faker'

FactoryGirl.define do
  factory :staffing_request do |f|
    f.requested_date_time Time.now
    association :staff, factory: :org_staff, strategy: :build
    association :staffing_requirement, strategy: :build
  end

end