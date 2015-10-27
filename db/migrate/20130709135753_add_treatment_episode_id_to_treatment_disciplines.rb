class AddTreatmentEpisodeIdToTreatmentDisciplines < ActiveRecord::Migration
  def change
    add_column :treatment_disciplines, :treatment_episode_id, :integer

    PatientTreatment.all.each{|treatment|
      treatment_disciplines = treatment.treatment_disciplines
      treatment.treatment_disciplines.update_all(:treatment_episode_id => -1) if treatment.treatment_episodes.empty?
      treatment.treatment_episodes.each_with_index{|episode, index|
        treatment_disciplines.each{|td|
          if(index == 0)
            td.treatment_episode = episode
            td.save!
          else
            episode.treatment_disciplines.create!(discipline: td.discipline, treatment: treatment)
          end
        }
      }
    }

  end
end
