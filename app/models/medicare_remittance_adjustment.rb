class MedicareRemittanceAdjustment < ActiveRecord::Base

  belongs_to :medicare_remittance_claim
  belongs_to :medicare_remittance_claim_line_item
  belongs_to :adjustment, :polymorphic => true

  audited :associated_with => :medicare_remittance_claim, :allow_mass_assignment => true

  def code
    group_code ? (group_code + "-" + reason_code) : reason_code
  end

end