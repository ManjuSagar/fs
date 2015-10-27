class CredentialTypeDisciplineIsNull < ActiveRecord::Migration
  def change
    change_column :field_staff_credential_types, :discipline_id, :integer, :null => true
  end
end
