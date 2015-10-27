require 'faker'

FactoryGirl.define do
  factory :user do |f|
    f.first_name {"#{Faker::Name.first_name}" }
    f.last_name "#{Faker::Name.last_name}"
    f.email { "#{Faker::Name.first_name}_#{Faker::Name.last_name}@gmail.com" }
    f.password "test1234"
    f.zip_code "90025"
  end
end