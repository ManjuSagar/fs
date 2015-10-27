class AddInitialHippsCodeToTreatmentEpisodes < ActiveRecord::Migration
  def change
    add_column :treatment_episodes, :initial_hipps_code, :string
    add_column :treatment_episodes, :treatment_authorization, :string
  end
end
