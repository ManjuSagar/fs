class AddReceivableIdToMedicareRemittanceLineItem < ActiveRecord::Migration
  def change
    add_column :medicare_remittance_claim_line_items, :receivable_id, :integer
    add_column :medicare_remittances, :org_id, :integer
  end
end
