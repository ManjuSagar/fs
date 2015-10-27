class MedicalOrderUploads < Mahaswami::FormPanel

  def initialize(conf = {}, parent_id = nil)
    mo = MedicalOrder.find(conf[:record_id])
    mo.attachment_type = AttachmentType.medical_order(mo.treatment.patient.org.id) if mo
    conf[:record] = mo
    super
  end

  def configuration
    s = super
    mo_record = s[:record]
    s.merge(
        model: "MedicalOrder",
        strong_default_attrs: ((mo_record and mo_record.treatment) ? {attachment_type: AttachmentType.medical_order(mo_record.treatment.patient.org.id) } : {}),
        file_upload: true,
        items: [
            {name: :attachment_type__attachment_description, field_label: "Attachment Type", read_only: true},
            {name: :signed_order_file_name, field_label: "File Name", value: "Medical Order", manually_required: true},
            {name: :signed_order, field_label: "Select File", xtype: 'fileuploadfield', getter: lambda {|r| ""}, display_only: true},
            {name: :signed_order_updated_at, field_label: "Received Date", value: Time.current.strftime("%m/%d/%Y %H:%M"), dateFormat: "m/d/Y", timeFormat: "H:i", manually_required: true},
            {name: :signed_order_uploading, hidden: true, value: true},
        ]
    )
  end
end