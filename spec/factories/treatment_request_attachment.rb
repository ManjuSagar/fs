require 'faker'

FactoryGirl.define do
  factory :treatment_request_attachment do |i|
    association :attachment_type, strategy: :build
    association :treatment_request, strategy: :build
    i.request_id {Faker::Number}
    i.attachment_file_name "route_sheet.jpg"
    i.attachment_content_type "image/jpeg"
    i.attachment_file_size 18461
    i.attachment_name "Referral"
  end
end