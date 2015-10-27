require 'faker'

FactoryGirl.define do
  factory :attachment_type do |i|
    i.attachment_code "REFERRAL"
    i.attachment_description "referral"
  end
end