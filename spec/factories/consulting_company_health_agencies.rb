require 'faker'

FactoryGirl.define do
  factory :consulting_company_health_agency do |f|
    association :consulting_company, strategy: :build
    association :health_agency, strategy: :build
  end
end