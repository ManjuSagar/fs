class EpisodeIdInMo < ActiveRecord::Migration
  def up
    rename_column :medical_orders, :treatment_episode, :treatment_episode_id
  end

  def down
  end
end
