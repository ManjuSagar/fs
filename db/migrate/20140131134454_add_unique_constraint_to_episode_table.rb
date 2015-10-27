class AddUniqueConstraintToEpisodeTable < ActiveRecord::Migration
  def change
    add_index :treatment_episodes, [:treatment_id,:start_date,:end_date], unique: true, :name => 'treatment_episode_dates'
  end
end

