require 'faker'

FactoryGirl.define do
  factory :treatment_activity do |f|
    f.activity_reason_code "01"
    f.activity_date "04/05/2014"
    f.discipline_id {Faker::Number}
    f.treatment_id {Faker::Number}
    f.activity_type "D"
    f.episode {Faker::Number}
  end

end
