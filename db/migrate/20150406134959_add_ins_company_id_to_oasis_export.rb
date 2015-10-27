class AddInsCompanyIdToOasisExport < ActiveRecord::Migration
  def change
    add_column :oasis_exports, :insurance_company_id, :integer
  end
end
