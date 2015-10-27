class FdaDrugLibrary < ActiveRecord::Base

  belongs_to :form, class_name: "DosageForm"
  belongs_to :company, class_name: "DrugCompany"

  audited :associated_with => :company, :allow_mass_assignment => true

end