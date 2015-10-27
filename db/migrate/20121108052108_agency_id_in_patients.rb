class AgencyIdInPatients < ActiveRecord::Migration
  def up
    add_column :patients, :health_agency_id, :integer, :null => false
    remove_column :patient_treatments, :health_agency_id
  end

  def down
  end
end
