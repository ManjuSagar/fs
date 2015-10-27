class AddAttachmentTypeIdToMedicalOrders < ActiveRecord::Migration
  def change
    add_column :medical_orders, :attachment_type_id, :integer, :null => true
    a = AttachmentType.create(:attachment_code => "MEDICAL_ORDER", :attachment_description => "Medical Order")
    MedicalOrder.update_all({:attachment_type_id => a.id})
  end
end
