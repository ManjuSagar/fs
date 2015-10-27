class AddAttachmentDateToAttachments < ActiveRecord::Migration
  def change
    add_column :treatment_attachments, :attachment_date, :date
    add_column :treatment_request_attachments, :attachment_date, :date
    add_column :visit_attachments, :attachment_date, :date

    TreatmentAttachment.reset_column_information
    TreatmentRequestAttachment.reset_column_information
    VisitAttachment.reset_column_information

    TreatmentAttachment.all.each do |attachment|
      attachment.update_column(:attachment_date, attachment.attachment_updated_at.to_date)
    end

    TreatmentRequestAttachment.all.each do |attachment|
      attachment.update_column(:attachment_date, attachment.attachment_updated_at.to_date)
    end

    VisitAttachment.all.each do |attachment|
      attachment.update_column(:attachment_date, attachment.attachment_updated_at.to_date)
    end


  end
end
