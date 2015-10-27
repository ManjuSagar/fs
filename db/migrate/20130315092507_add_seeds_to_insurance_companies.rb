class AddSeedsToInsuranceCompanies < ActiveRecord::Migration
  def change
    InsuranceCompany.delete_all
    InsuranceCompany.reset_column_information
  end
end
