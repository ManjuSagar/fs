class AddPayableRateToOrgFieldStaffVisitTypes < ActiveRecord::Migration
  def change
    add_column :org_field_staff_visit_types, :payable_rate, :decimal, :precision => 8, :scale => 2
  end
end
