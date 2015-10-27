class AddTreatmentEpisodeColumnToAllDocuments < ActiveRecord::Migration

  def change
    add_column :treatment_attachments, :treatment_episode_id, :integer
    TreatmentAttachment.all.each{|ta|
      e = ta.treatment.treatment_episodes.first if ta.treatment
      ta.treatment_episode_id = e ? e.id : -1
      ta.save(:validate => false)
    }
    change_column :treatment_attachments, :treatment_episode_id, :integer, :null => false

    add_column :document_notes, :treatment_episode_id, :integer
    DocumentNote.all.each{|dn|
      d = dn.document
      dn.treatment_episode_id = d ? d.treatment_episode_id : -1
      dn.save!
    }
    change_column :document_notes, :treatment_episode_id, :integer, :null => false

    add_column :all_documents, :treatment_episode_id, :integer
    AllDocument.all.each{|d|
      d.treatment_episode_id = (d.documentable and d.documentable.treatment_episode_id) ? d.documentable.treatment_episode_id : -1
      d.save!
    }
    change_column :all_documents, :treatment_episode_id, :integer, :null => false
  end
end
