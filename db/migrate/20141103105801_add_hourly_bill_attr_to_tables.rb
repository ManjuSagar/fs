class AddHourlyBillAttrToTables < ActiveRecord::Migration
  def change
    add_column :org_field_staff_visit_types, :hourly_rate, :decimal, :precision => 8, :scale => 2
    rename_column :org_field_staff_visit_types, :payable_rate, :visit_rate

    add_column :insurance_company_visit_type_rates, :hourly_rate, :decimal, :precision => 8, :scale => 2
    rename_column :insurance_company_visit_type_rates, :rate, :visit_rate

    add_column :ha_sc_contract_vt_rates, :hourly_rate, :decimal, :precision => 8, :scale => 2
    rename_column :ha_sc_contract_vt_rates, :chargeable_rate, :visit_rate

    add_column :treatment_requests, :insurance_bill_type, :string, :limit => 2, :default => 'V'
    add_column :treatment_requests, :field_staff_bill_type, :string, :limit => 2, :default => 'V'

    add_column :payables, :unit, :string, :limit => 2
    add_column :payables, :rate, :decimal, :precision => 8, :scale => 2
    add_column :payables, :no_of_units, :decimal, :precision => 8, :scale => 2
  end
end
