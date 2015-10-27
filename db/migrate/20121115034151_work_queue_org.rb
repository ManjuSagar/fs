class WorkQueueOrg < ActiveRecord::Migration
  def up
    add_column :work_queue, :org_id, :integer, :null => false

    add_column :org_contacts, :contact_type_id, :integer

    OrgContact.all.each{|a| a.update_attribute(:contact_type_id, -1)}
    change_column :org_contacts, :contact_type_id, :integer, :null => false

    remove_column :patients, :dob
    remove_column :patients, :ssn
    remove_column :patients, :marital_status
    remove_column :patients, :gender
    remove_column :patients, :patient_detail_id
    remove_column :patients, :health_agency_id

    add_column :patient_details, :dob, :date, :null => false
    add_column :patient_details, :ssn, :string, :limit => 9
    add_column :patient_details, :marital_status, :string, :limit => 1, :null => false
    add_column :patient_details, :gender, :string, :limit => 1, :null => false
  end

  def down
  end
end
