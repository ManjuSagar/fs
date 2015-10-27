class AddSortableColumnsToAllDocuments < ActiveRecord::Migration
  def change
    add_column :all_documents, :category, :string
    add_column :all_documents, :staff, :string
    add_column :all_documents, :description, :string
    add_column :all_documents, :status, :string

    AllDocument.reset_column_information
    AllDocument.all.each{|d|
      d.category = if d.documentable_type == "Document"
                     d.documentable.document_definition.document_name.split(" ").first
                   elsif d.documentable_type == "TreatmentAttachment"
                     "Attachment"
                   elsif d.documentable_type == "CommunicationNote"
                     "Communication"
                   elsif d.documentable_type == "MedicalOrder"
                     "Order"
                   else
                     d.documentable_type.titleize
                   end

      d.staff = if d.documentable_type == "DocumentNote"
		  d.documentable.document.field_staff.full_name if d.documentable.document.field_staff
                elsif d.documentable_type == "TreatmentAttachment"
                  nil
                else
                  d.documentable.field_staff.full_name if d.documentable.field_staff
                end

      d.description = if d.documentable_type == "Document"
                        d.documentable.document_definition.document_name.split(" ").last
                      elsif d.documentable_type == "CommunicationNote"
                        d.documentable.note_type.type_description
                      elsif d.documentable_type == "MedicalOrder"
                        d.documentable.order_type.type_description
                      elsif d.documentable_type == "TreatmentAttachment"
                        d.documentable.attachment_type.attachment_description if d.documentable.attachment_type
                      end

      d.status = if d.documentable_type == "Document"
                   d.documentable.status.to_s.titleize
                 elsif d.documentable_type == "CommunicationNote"
                   d.documentable.note_status.to_s.titleize
                 elsif d.documentable_type == "MedicalOrder"
                   d.documentable.order_status.to_s.titleize
                 end
      d.save!
    }

  end
end
