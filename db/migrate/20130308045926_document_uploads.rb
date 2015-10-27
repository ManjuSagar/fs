class DocumentUploads < ActiveRecord::Migration
  def up
    create_table :form_library, :force => true do |t|
      t.string :form_name, :null => false, :limit => 50
      t.string :form_description, :null => false, :limit => 255
      t.has_attached_file :form_content
      t.string :scope, :limit => 2
    end
  end

  def down
  end
end
