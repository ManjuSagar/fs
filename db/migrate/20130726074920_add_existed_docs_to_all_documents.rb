class AddExistedDocsToAllDocuments < ActiveRecord::Migration
  def change
    documents =  Document.all
    documents += TreatmentAttachment.all
    documents +=  MedicalOrder.all
    documents += DocumentNote.all
    documents += CommunicationNote.all
    AllDocument.reset_column_information
    documents.each{|d|
      d.all_documents.create!({treatment_episode_id:
         (d.treatment_episode_id) ? d.treatment_episode_id : -1})
    }
  end
end
