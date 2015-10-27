class AddHippsVersionToEpisodes < ActiveRecord::Migration
  def change
    add_column :treatment_episodes, :hipps_version, :string
  end
end
