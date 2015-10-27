class AddBillingCertificateDetailsToHealthAgency < ActiveRecord::Migration
  def change
    add_column :health_agency_details, :clm_billing_cert_alias_name, :string, limit: 150
    add_column :health_agency_details, :clm_billing_cert_password, :string, limit: 150
    add_column :health_agency_details, :submitter_id, :string, limit: 25

  end
end
