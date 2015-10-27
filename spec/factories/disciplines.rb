require 'faker'

FactoryGirl.define do
  factory :discipline do |f|
    f.discipline_code 'PT'
    f.discipline_description '"Physical Therapy"'
  end
end