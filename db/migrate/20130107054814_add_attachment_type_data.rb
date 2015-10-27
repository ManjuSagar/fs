class AddAttachmentTypeData < ActiveRecord::Migration
  def change
    if AttachmentType.all.empty?
      AttachmentType.create!(:attachment_code => "ROUTE_SHEET", :attachment_description => "Route Sheet")
      AttachmentType.create!(:attachment_code => "MAP", :attachment_description => "Map" )
      AttachmentType.create!(:attachment_code => "SIGNATURE", :attachment_description => "Signature")
      AttachmentType.create!(:attachment_code => "REFERRAL", :attachment_description => "Referral")
      AttachmentType.create!(:attachment_code => "MEDICAL_ORDER", :attachment_description => "Medical Order")
      AttachmentType.create!(:attachment_code => "DOCUMENT", :attachment_description => "Document")
      AttachmentType.create!(:attachment_code => "OTHERS", :attachment_description => "Others")
    end
  end
end
