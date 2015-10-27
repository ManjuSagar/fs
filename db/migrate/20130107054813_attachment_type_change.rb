class AttachmentTypeChange < ActiveRecord::Migration
  def change
    create_table :attachment_types do |t|
      t.string :attachment_code, :null => false, :limit => 50
      t.string :attachment_description, :null => false, :limit => 100

      t.timestamps
    end
  end
end
