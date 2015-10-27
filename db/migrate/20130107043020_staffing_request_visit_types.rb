class StaffingRequestVisitTypes < ActiveRecord::Migration
  def up
    create_table :staffing_request_visit_types, :force => true do |t|
      t.integer :staffing_request_id, :null => false
      t.integer :visit_type_id, :null => false
      t.string :request_status, :limit => 1, :null => false, :default => 'N'
    end
  end

  def down
  end
end
