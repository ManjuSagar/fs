class MedicareRemittanceProviderAdjustment < ActiveRecord::Base
  belongs_to :medicare_remittance

  audited :associated_with => :medicare_remittance, :allow_mass_assignment => true

end