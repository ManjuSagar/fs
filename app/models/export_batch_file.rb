class ExportBatchFile < ActiveRecord::Base

  has_attached_file :oasis_export
  has_many :oasis_export_batches
  has_many :oasis_exports, :through => :oasis_export_batches

  audited :allow_mass_assignment => true

end
