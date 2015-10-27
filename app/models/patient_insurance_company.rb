class PatientInsuranceCompany < ActiveRecord::Base

  belongs_to :patient
  belongs_to :insurance_company

  scope :org_scope, -> {includes(:patient=>:patient_detail).where({:patient_details => {:org_id=> Org.current.id}})}

  audited :associated_with => :patient, :allow_mass_assignment => true

  RELATIONSHIPS = [["01", "Spouse"], ["18", "Self"], ["19", "Child"], ["20", "Employee"], ["21", "Unknown"],["39", "Organ Donor"],
                   ["40", "Cadaver Donor"], ["53", "Life Partner"], ["G8", "Other Relationship"]]
  validates_uniqueness_of :insurance_company_id, :scope => [:patient_id], message: " already exists."


  validates :patient, :presence => true
  validates :insurance_company, :presence => true
  validates :patient_insurance_number, :presence => true
  validates :effective_date, :presence => true

  def relation_to_insured_display
    relation = RELATIONSHIPS.detect{|x| x[0] == self.relation_to_insured}
    relation.present? ? relation[1] :""
  end

end

