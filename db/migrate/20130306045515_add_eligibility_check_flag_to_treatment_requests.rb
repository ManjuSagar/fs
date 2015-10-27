class AddEligibilityCheckFlagToTreatmentRequests < ActiveRecord::Migration
  def change
    add_column :treatment_requests, :eligibility_check_flag, :boolean, :default => false
  end
end
