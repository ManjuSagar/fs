class AddColumnToRapGeneratedDocToTreatmentEpisode < ActiveRecord::Migration
  def change
    add_column :treatment_episodes, :rap_generated_document, :integer
  end
end
