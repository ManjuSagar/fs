class AddColumnPreferredGenderToTreatmentRequest < ActiveRecord::Migration
  def change
    remove_column :treatment_requests, :gender_mandatory_flag
    add_column :treatment_requests, :preferred_gender, :string, :limit => 1
  end
end
