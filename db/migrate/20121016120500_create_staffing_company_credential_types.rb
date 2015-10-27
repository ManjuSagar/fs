class CreateStaffingCompanyCredentialTypes < ActiveRecord::Migration
  def change
    create_table :staffing_company_credential_types do |t|
      t.string :ct_code, :limit => 15, :null => false
      t.string :ct_description, :limit => 100, :null => false
      t.boolean :expiry_flag, :null => false
      t.timestamps
    end
  end
end
