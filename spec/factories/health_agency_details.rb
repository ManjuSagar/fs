require 'faker'

FactoryGirl.define do
  factory :health_agency_detail do |f|
    f.provider_number "A08123456"
    f.cms_cert_number "123457"
    f.npi_number "1234567894"
    f.submitter_id "A08123456"

  end
end