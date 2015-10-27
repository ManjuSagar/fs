class Documentation < ActiveRecord::Migration
  def up
    create_table :document_form_templates, :force => true do |t|
      t.string :template_name, :limit => 30, :null => false
      t.string :template_description
      t.string :document_class_name, :limit => 100, :null => false
      t.text :input_template_content
      t.text :report_template_content
      t.string :status, :limit => 2, :null => false
    end

    create_table :document_definitions, :force => true do |t|
      t.string :document_code, :limit => 20, :null => false
      t.string :document_name, :limit => 100, :null => false
      t.integer :document_form_template_id, :null => false
      t.boolean :tied_to_visit_flag, :default => false
      t.string :status, :limit => 2, :null => false
    end

    create_table :documents, :force => true do |t|
      t.integer :document_definition_id, :null => false
      t.string :document_type, :null => false
      t.integer :document_form_template_id, :null => false
      t.date :document_date
      t.text :data
      t.string :status, :limit => 2, :null => false
    end

  end

  def down
  end
end
