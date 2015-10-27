class AddTreatmentIdToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :treatment_id, :integer
    Invoice.update_all(:treatment_id => -1)
    change_column :invoices, :treatment_id, :integer, :null => false
  end
end
