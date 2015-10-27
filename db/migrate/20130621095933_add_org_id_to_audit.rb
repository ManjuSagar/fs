class AddOrgIdToAudit < ActiveRecord::Migration
  def change
    add_column :audits, :org_id, :integer

    Audit.all.each{|audit|
      begin
        org_id =  case audit.associated_type
                  when "PatientTreatment"
                    audit.associated.patient.patient_detail.org_id
                  when "TreatmentRequest"
                    audit.associated.patient.patient_detail.org_id
                  when "Org"
                    audit.associated_id
                  when "Document"
                    audit.associated.treatment.patient.patient_detail.org_id
                  when "User"
                    audit.associated.patient_detail.org_id
                  when "TreatmentVisit"
                    audit.associated.treatment.patient.patient_detail.org_id
                  when "PatientDetail"
                    audit.associated.org_id
                  end
      rescue
        puts "Can't find org_id. Some records are deleted."
        puts audit.id
      end
      audit.org_id = org_id ? org_id : -1
      audit.save!
    }

    change_column :audits, :org_id, :integer, :null => false
  end
end
