class StaffingRefactored < ActiveRecord::Migration
  def up
    create_table :treat_req_visit_types, :force => true do |t|
      t.integer :request_id, :null => false
      t.integer :visit_type_id, :null => false
      t.string :request_status, :limit => 1, :null => false
      t.integer :lock_version, :default => 0, :null => false
    end

    create_table :treatment_request_staffs, :force => true do |t|
      t.integer :request_id, :null => false
      t.string :staff_type, :limit => 100, :null => false
      t.integer :staff_id, :null => false
      t.integer :discipline_id
      t.integer :visit_type_id
      t.integer :lock_version, :default => 0, :null => false
    end

    create_table :visit_type_licence_types, :force => true do |t|
      t.integer :visit_type_id, :null => false
      t.integer :license_type_id, :null => false
      t.integer :lock_version, :default => 0, :null => false
    end

    create_table :staffing_masters, :force => true do |t|
      t.string :staffable_type, :limit => 100, :null => false
      t.integer :staffable_id, :null => false
      t.datetime :created_date_time, :null => false
      t.string :staffing_status, :limit => 1, :null => false
      t.text :narrative
      t.integer :lock_version, :default => 0, :null => false
    end

    create_table :staffing_requirements, :force => true do |t|
      t.integer :staffing_master_id, :null => false
      t.integer :discipline_id
      t.integer :visit_type_id
      t.string :staffing_status, :limit => 1, :null => false
      t.integer :lock_version, :default => 0, :null => false
    end

    remove_column :staffing_requests, :request_discipline_id
    add_column :staffing_requests, :staffing_requirement_id, :integer, :null => false
    add_column :staffing_requests, :discipline_id, :integer
    add_column :staffing_requests, :visit_type_id, :integer
    rename_column :staffing_requests, :requested_entity_type, :staff_type
    rename_column :staffing_requests, :requested_entity_id, :staff_id

    create_table :treatment_staffs, :force => true do |t|
      t.integer :treatment_id, :null => false
      t.string :staff_type, :limit => 100, :null => false
      t.integer :staff_id, :null => false
      t.integer :discipline_id
      t.integer :visit_type_id
      t.integer :lock_version, :default => 0, :null => false
    end
  end

  def down
  end
end
