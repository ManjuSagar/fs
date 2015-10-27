class StaffingTables < ActiveRecord::Migration
  def up
    create_table :staffing_company_details, :force => true do |t|
      t.integer :staffing_company_id, :null => false
      t.integer :created_org_id, :null => false
      t.integer :lock_version, :default => 0
    end

    create_table :staffing_requests, :force => true do |t|
      t.integer :request_discipline_id, :null => false
      t.string :requested_entity_type, :limit => 100, :null => false
      t.integer :requested_entity_id, :null => false
      t.datetime :requested_date_time, :null => false
      t.string :request_status, :limit => 1, :null => false
      t.integer :lock_version, :default => 0
    end

    create_table :treat_staffing_companies, :force => true do |t|
      t.integer :treatment_id, :null => false
      t.integer :staffing_company_id, :null => false
      t.integer :lock_version, :default => 0
    end
  end

  def down
  end
end
