class AddAttachmentFields < ActiveRecord::Migration
  def up
    add_column :visit_attachments, :attachment_name, :string, :limit => 100
    add_column :visit_attachments, :created_at, :datetime
  end

  def down
  end
end
