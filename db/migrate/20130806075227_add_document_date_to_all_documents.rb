class AddDocumentDateToAllDocuments < ActiveRecord::Migration
  def change
    add_column :all_documents, :document_date, :date
    AllDocument.reset_column_information
      AllDocument.all.each do |doc|
        document = doc.documentable
        if doc.documentable_type == "MedicalOrder"
          doc.update_column(:document_date, document.order_date.to_date)
        elsif doc.documentable_type == "CommunicationNote"
          doc.update_column(:document_date, document.note_date_time.to_date)
        elsif doc.documentable_type == "TreatmentAttachment"
          doc.update_column(:document_date, document.attachment_date)
        elsif doc.documentable_type == "Document"
          doc.update_column(:document_date, document.document_date)
        elsif doc.documentable_type == "DocumentNote"
          doc.update_column(:document_date, document.note_date.to_date)
        end
      end
  end
end
