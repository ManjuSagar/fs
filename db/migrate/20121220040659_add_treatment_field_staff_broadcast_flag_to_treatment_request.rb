class AddTreatmentFieldStaffBroadcastFlagToTreatmentRequest < ActiveRecord::Migration
  def change
    add_column :treatment_requests, :broadcast_staffing_request_flag, :boolean, :default => false
  end
end
