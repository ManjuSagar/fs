class AddCoSignatureOptionalToHealthAgencyDetails < ActiveRecord::Migration
  def change
    add_column :health_agency_details, :co_signature_optional, :boolean, :default => false
  end
end
