# == Schema Information
#
# Table name: insurance_company_visit_type_rates
#
#  id                       :integer          not null, primary key
#  org_id                   :integer          not null
#  insurance_company_id     :integer          not null
#  visit_type_id            :integer          not null
#  rate                     :decimal(8, 2)    not null
#  external_visit_type_code :string(20)       not null
#  lock_version             :integer          default(0)
#

require 'test_helper'

class InsuranceCompanyVisitTypeRateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
