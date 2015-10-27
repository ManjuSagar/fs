class OasisExportBatch < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :oasis_export
  belongs_to :export_batch_file

  audited :associated_with => :oasis_export, :allow_mass_assignment => true

end
