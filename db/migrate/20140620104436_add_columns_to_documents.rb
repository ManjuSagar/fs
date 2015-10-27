class AddColumnsToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :correction_num, :integer
    add_column :documents, :unlock_reason, :string, :limit => 2
    add_column :documents, :created_at, :datetime
    add_column :documents, :updated_at, :datetime
  end
end
