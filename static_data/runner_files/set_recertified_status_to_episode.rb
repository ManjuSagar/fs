treatments = PatientTreatment.all
treatments.each do |treatment|
    treatment.treatment_episodes.each do |episode|
      if treatment.next_episode(episode)
        episode.episode_status = "RC"
        res = episode.save!(:validate => false)
      end
    end
end