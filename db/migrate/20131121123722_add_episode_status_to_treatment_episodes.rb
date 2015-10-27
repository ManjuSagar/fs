class AddEpisodeStatusToTreatmentEpisodes < ActiveRecord::Migration
  def change
    add_column :treatment_episodes, :episode_status, :string, :limit => 2
  end
end
