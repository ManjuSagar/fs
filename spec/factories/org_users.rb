require 'faker'

FactoryGirl.define do
  factory :org_user do |f|
    association :org, factory: :health_agency, strategy: :build
    association :user, strategy: :build
    f.user_status "A"
  end
end