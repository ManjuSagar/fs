class AddPaymentDueDaysAndFormTypeToInsCompanies < ActiveRecord::Migration
  def change
    add_column :insurance_companies, :claim_payment_due_days, :integer, :default => 0
    add_column :insurance_companies, :claim_form_type, :string, :limit => 2
  end
end
