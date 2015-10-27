class AddAliasNameAndCertificateToHealthAgencyDetails < ActiveRecord::Migration
  def change
    add_column :health_agency_details, :certificate_alias_name, :string
    add_column :health_agency_details, :certificate_password, :string
  end
end
