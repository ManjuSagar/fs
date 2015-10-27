# == Schema Information
#
# Table name: payment_sources
#
#  id          :string(2)        not null, primary key
#  description :string(100)
#

class PaymentSource < ActiveRecord::Base
  attr_accessible :id, :description

  MEDICARE_ADV = self.find_by_description("Medicare (HMO/managed care/Advantage plan)")
  MEDICARE_FEE = self.find_by_description("Medicare (traditional fee-for-service)")
  MEDICAID_ADV = self.find_by_description("Medicaid (HMO/managed care)")
  MEDICAID_FEE = self.find_by_description("Medicaid (traditional fee-for-service)")

  def to_s
    self.description
  end

  def medicare?
    (self == MEDICARE_ADV or self == MEDICARE_FEE)
  end

  def medicaid?
    (self == MEDICAID_ADV or self == MEDICAID_FEE)
  end
end
