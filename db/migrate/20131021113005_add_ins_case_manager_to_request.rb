class AddInsCaseManagerToRequest < ActiveRecord::Migration
  def change
    add_column :treatment_requests, :insurance_case_manager_id, :integer
  end
end
