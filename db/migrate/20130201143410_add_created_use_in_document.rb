class AddCreatedUseInDocument < ActiveRecord::Migration
  def change
    Document.delete_all
    add_column :documents, :created_user_id, :integer, :null => false
  end
end
