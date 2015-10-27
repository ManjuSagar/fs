class RemoveVisitStatusAndAddVitalBpCol < ActiveRecord::Migration
  def up
    remove_column :treat_req_disciplines, :request_status
    remove_column :treat_req_visit_types, :request_status
    add_column :treatment_vitals, :bp_read_location, :string, :limit => 1
  end

  def down
  end
end
