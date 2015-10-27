class AddSystemRequiredColumnToAttachmentType < ActiveRecord::Migration
  def change
    add_column :attachment_types, :system_required, :boolean, :default => true, :null => false
    add_column :attachment_types, :type_status, :string, :limit => 1
    AttachmentType.update_all(:type_status => 'A')
    change_column :attachment_types, :type_status, :string, :limit => 1, :null => false
  end
end
