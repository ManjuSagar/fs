class AddDataColumnToStaffingRequests < ActiveRecord::Migration
  def change
    add_column :staffing_requests, :data, :text
  end
end
