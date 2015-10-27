class AddCmsCertificationNumberToAgency < ActiveRecord::Migration
  def change
    add_column :health_agency_details, :cms_cert_number, :string
  end
end
