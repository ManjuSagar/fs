class ActiveRecord::Base

  before_save :set_audit_comment
  before_create :assign_org_id

  def audit_model?
    self.class.name.to_s == "Audited::Adapters::ActiveRecord::Audit"
  end

  private

  def set_audit_comment
    if audit_model?
      class_name = self.auditable_type.to_s
      unless Thread.current[:events].blank?
        primary_event = Thread.current[:events]["primary_event"]
        event = Thread.current[:events]["#{class_name}_#{auditable_id}"]
        self.comment = event ? "#{primary_event}, #{event}" : primary_event
      end
    end
  end

  def assign_org_id
    if audit_model?
      if Rails.env == "test"
        self.org_id = -1
      elsif User.current and User.current.office_staff?
        self.org_id = Org.current.id
      elsif associated_type.present?
        org_id =  case associated_type
                    when "PatientTreatment"
                      associated.patient.patient_detail.org_id
                    when "TreatmentRequest"
                      associated.patient.patient_detail.org_id
                    when "Org"
                      associated_id
                    when "Document"
                      associated.treatment.patient.patient_detail.org_id
                    when "TreatmentVisit"
                      associated.treatment.patient.patient_detail.org_id
                    when "PatientDetail"
                      associated.org_id
                    when "TreatmentEpisode"
                      associated.treatment.patient.patient_detail.org_id
                    when "VisitType"
                      associated.org_id
                    when "StaffingCompanyContract"
                      associated.health_agency_id
                    when "InsuranceCompany"
                      associated.org_id
                    when "MedicareRemittanceClaim"
                      associated.invoice.org_id
                    when "MedicareRemittance"
                      associated.org_id
                    when "OasisExport"
                      associated.oasis_document.treatment.patient.patient_detail.org_id
                    when "OrgUser"
                      associated.org_id
                    when "Patient"
                      associated.org_id
                    when "StaffingRequirement"
                      staffable = associated.staffing_master.staffable
                      staffable.patient.patient_detail.org_id
                    when "StaffingMaster"
                      staffable = associated.staffable
                      staffable.patient.patient_detail.org_id
                  end
        self.org_id = org_id ? org_id : -1
      else
        self.org_id = -1
      end

    end
  end

end
