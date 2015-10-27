class GlobalStuff < ActiveRecord::Migration
  def up
    create_table :license_types, :force => true do |t|
      t.integer :discipline_id, :null => false
      t.string :license_type_code, :limit => 5, :null => false
      t.string :license_type_description, :limit => 30, :null => false
    end

    create_table :document_defn_sets, :force => true do |t|
      t.string :set_name, :limit => 50, :null => false
      t.string :set_description, :limit => 100, :null => false
      t.string :remarks, :limit => 200
      t.timestamps
    end

    create_table :document_defn_set_details, :force => true do |t|
      t.integer :document_defn_set_id, :null => false
      t.integer :document_definition_id, :null => false
    end

    add_column :document_definitions, :system_supplied_flag, :boolean, :default => false
    add_column :document_definitions, :org_id, :integer

    DocumentDefinition.all.each {|x| x.update_attribute(:org_id, -1)}
    change_column :document_definitions, :org_id, :integer, :null => false

    create_table :document_form_tpl_sets, :force => true do |t|
      t.string :set_name, :limit => 50, :null => false
      t.string :set_description, :limit => 100, :null => false
      t.string :remarks, :limit => 200
      t.timestamps
    end

    create_table :doc_form_tpl_set_details, :force => true do |t|
      t.integer :document_form_tpl_set_id, :null => false
      t.integer :document_form_template_id, :null => false
    end

    add_column :health_agency_details, :document_form_tpl_set_id, :integer
  end

  def down
  end
end
