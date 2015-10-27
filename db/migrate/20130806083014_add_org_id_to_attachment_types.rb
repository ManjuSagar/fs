class AddOrgIdToAttachmentTypes < ActiveRecord::Migration
  def change
    add_column :attachment_types, :org_id, :integer

    f = FacilityOwner.first
    Org.current = f
    attachment_types = AttachmentType.all

    attachment_types.each do |attach_type|
      attach_type.update_column(:org_id, f.id)
    end

    health_agencies = Org.where(:org_type => "HealthAgency")

    health_agencies.each do |ha|
      Org.current = ha
      attachment_types.each{|attach_type|
        ha.attachment_types.create!(attach_type.attributes.reject{|k,v| ["id", "org_id", "lock_version"].include? k.to_s})
      }
    end

    TreatmentRequestAttachment.all.each do |tr|
      org_id = tr.treatment_request.patient.patient_detail.org_id
      type_code = tr.attachment_type.attachment_code if tr.attachment_type
      tr.attachment_type = AttachmentType.find_by_org_id_and_attachment_code(org_id, type_code)
      tr.save
    end

    VisitAttachment.all.each do |r|
      org_id = r.treatment_visit.treatment.patient.patient_detail.org_id if r.treatment_visit and r.treatment_visit.treatment
      type_code = r.attachment_type.attachment_code if r.attachment_type
      r.attachment_type = AttachmentType.find_by_org_id_and_attachment_code(org_id, type_code)
      r.save
    end

    TreatmentAttachment.all.each do |r|
      org_id = r.treatment.patient.patient_detail.org_id if r.treatment
      type_code = r.attachment_type.attachment_code if r.attachment_type
      r.attachment_type = AttachmentType.find_by_org_id_and_attachment_code(org_id, type_code)
      r.save
    end

    MedicalOrder.all.each do |r|
      org_id = r.treatment.patient.patient_detail.org_id if r.treatment
      type_code = r.attachment_type.attachment_code if r.attachment_type
      r.attachment_type = AttachmentType.find_by_org_id_and_attachment_code(org_id, type_code)
      r.save
    end

  end
end
