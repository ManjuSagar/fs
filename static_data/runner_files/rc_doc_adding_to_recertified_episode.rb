PatientTreatment.all.each do |treatment|
  episodes = treatment.treatment_episodes.order("start_date")
  docs = []
  episodes_list = []
  episodes.each do |episode|
    next_episode = treatment.next_episode(episode)
    if next_episode.present?
      rc_doc = episode.documents.order("document_date DESC").detect{|d| (d.is_a? OasisRecertification) }
      if rc_doc
        docs << rc_doc
        episodes_list << next_episode
      end
    end
  end
  puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$4444444444444444444444444444$$$$$$$$$$$$$$$$$$$$$$$$$"
  puts docs.map(&:id)
  docs.each_with_index do |doc, index|
    e_id = episodes_list[index].id
    doc.update_column(:treatment_episode_id, e_id)
    all_doc = doc.all_documents.first
    all_doc.update_column(:treatment_episode_id, e_id)
  end

end