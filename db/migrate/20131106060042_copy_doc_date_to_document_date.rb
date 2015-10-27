class CopyDocDateToDocumentDate < ActiveRecord::Migration
  def change
    Document.all.each do |doc|
      doc_date = doc.data["doc_date"]
      d = doc.update_column(:document_date, doc_date) if doc_date
    end
  end
end
