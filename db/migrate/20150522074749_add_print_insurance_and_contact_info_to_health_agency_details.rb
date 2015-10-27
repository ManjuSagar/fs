class AddPrintInsuranceAndContactInfoToHealthAgencyDetails < ActiveRecord::Migration

  def up
    add_column :health_agency_details, :print_insurance_address, :boolean, default: false
  end

  def down
    remove_column :health_agency_details, :print_insurance_address
  end

end
