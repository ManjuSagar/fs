require 'faker'

FactoryGirl.define do
  factory :treatment_request do |i|
    association :patient, strategy: :build
    #association :insurance_company, strategy: :build
    i.point_of_origin '1'
    i.request_date  "07/10/2013"
    i.created_user_id {"#{Faker::Number}"}
  end
end