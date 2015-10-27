class UpdateAttachmentIdToAttachments < ActiveRecord::Migration
  def change
    AttachmentType.destroy_all
    a = AttachmentType.create(:attachment_code => "OTHERS", :attachment_description => "Others")
    add_column :visit_attachments, :attachment_type_id, :integer
    VisitAttachment.update_all(:attachment_type_id => a.id)
    change_column :visit_attachments, :attachment_type_id, :integer, :null => false

    add_column :treatment_attachments, :attachment_type_id, :integer
    TreatmentAttachment.update_all(:attachment_type_id => a.id)
    change_column :treatment_attachments, :attachment_type_id, :integer, :null => false

    add_column :treatment_request_attachments, :attachment_type_id, :integer
    TreatmentRequestAttachment.update_all(:attachment_type_id => a.id)
    change_column :treatment_request_attachments, :attachment_type_id, :integer, :null => false
  end



end
