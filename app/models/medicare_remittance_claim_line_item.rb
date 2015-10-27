class MedicareRemittanceClaimLineItem < ActiveRecord::Base

  belongs_to :medicare_remittance_claim
  has_many :medicare_remittance_adjustments, :as => :adjustment, dependent: :destroy
  belongs_to :receivable

  audited :associated_with => :medicare_remittance_claim, :allow_mass_assignment => true

  def patient_responsibility_amount
      line_item_deductible_amount.to_f + line_item_coinsurance_amount.to_f
  end

end