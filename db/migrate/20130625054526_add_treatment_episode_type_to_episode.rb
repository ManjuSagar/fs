class AddTreatmentEpisodeTypeToEpisode < ActiveRecord::Migration
  def change
    add_column :treatment_episodes, :episode_type, :string, :limit => 5
    TreatmentEpisode.reset_column_information

    episodes = TreatmentEpisode.all

    episodes.each do |epi|
      if epi.treatment
        ins = epi.treatment.treatment_request.insurance_company if epi.treatment.treatment_request
        if ins.present? and ins.medicare?
          epi.update_column(:episode_type, "FEWOO")
        end
        end
    end
  end
end

