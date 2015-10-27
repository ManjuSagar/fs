class StaffingMore < ActiveRecord::Migration
  def up
    add_column :treat_req_disciplines, :request_status, :string, :limit => 1, :null => false, :default => 'A'
  end

  def down
  end
end
