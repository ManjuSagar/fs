class AddMedicareBillStatusToEpisode < ActiveRecord::Migration
  def change
    add_column :treatment_episodes, :medicare_bill_status, :string, :limit => 1
    TreatmentEpisode.update_all(:medicare_bill_status => 'N')
    change_column :treatment_episodes, :medicare_bill_status, :string, :limit => 1, :null => false
  end
end
