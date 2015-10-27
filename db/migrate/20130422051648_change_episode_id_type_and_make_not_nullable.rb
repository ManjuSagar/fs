class ChangeEpisodeIdTypeAndMakeNotNullable < ActiveRecord::Migration
  def change
    remove_column :receivables, :treatment_episode_id	
    add_column :receivables, :treatment_episode_id, :integer
    Receivable.all.each{|receivable|
      treatment = receivable.treatment
      if treatment
        episode = treatment.current_episode
        receivable.treatment_episode = episode
        receivable.save!
      end
    }
  end
end
