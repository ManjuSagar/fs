class AddDisableDateToAttachmentType < ActiveRecord::Migration
  def change
    add_column :attachment_types, :disabled_date, :date
  end
end
