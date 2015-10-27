class AddNpiToHaAndMigrateExistingData < ActiveRecord::Migration
  def change
    add_column :health_agency_details, :npi_number, :string
    HealthAgencyDetail.reset_column_information
    health_agencies = Org.where(:org_type => "HealthAgency")
    health_agencies.each do |ha|
      ha.health_agency_detail.update_column(:npi_number, ha.npi_number)
    end
    remove_column :orgs, :npi_number
  end
end
