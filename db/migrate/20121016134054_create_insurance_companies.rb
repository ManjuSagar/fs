class CreateInsuranceCompanies < ActiveRecord::Migration
  def change
    create_table :insurance_companies do |t|
      t.string :company_name, :limit => 100, :null => false
      t.string :company_type, :limit => 50, :null => false

      t.timestamps
    end
  end
end
