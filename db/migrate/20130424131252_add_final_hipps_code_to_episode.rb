class AddFinalHippsCodeToEpisode < ActiveRecord::Migration
  def change
    add_column :treatment_episodes, :final_hipps_code, :string
  end
end
