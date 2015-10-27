class AddTransmissionColumnsToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :transmission_status, :string
    add_column :invoices, :next_check_time, :datetime
    add_column :invoices, :retry_count, :integer
    add_column :invoices, :transmission_note, :text
    add_column :invoices, :claim_control_number, :string
    change_column :medicare_claim_transmission_logs, :type_of_file, :string
    add_column :health_agency_details, :claims_electronic_transmission, :boolean, default: false
    add_column :medicare_claim_transmission_logs, :response_file_name, :string
    add_column :medicare_claim_transmission_logs, :uuid, :string
  end
end