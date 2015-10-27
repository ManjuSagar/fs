class AddSignedUserToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :signed_user, :integer
  end
end
