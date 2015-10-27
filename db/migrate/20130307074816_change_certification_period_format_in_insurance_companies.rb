class ChangeCertificationPeriodFormatInInsuranceCompanies < ActiveRecord::Migration
  def up
    change_column :insurance_companies, :certification_period, :integer, :default => 0
  end

  def down
  end
end
