require 'faker'
FactoryGirl.define do
  factory :staffing_company_contract do |f|
    association :staffing_company, strategy: :build
    association :health_agency, strategy: :build
    f.effective_from_date '2013-02-02'
    f.effective_to_date '2014-04-11'
  end
end