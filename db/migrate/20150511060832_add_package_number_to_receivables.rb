class AddPackageNumberToReceivables < ActiveRecord::Migration
  def change
    add_column :receivables, :invoice_package_id, :integer
    add_column :invoice_packages, :org_id, :integer
  end
end
