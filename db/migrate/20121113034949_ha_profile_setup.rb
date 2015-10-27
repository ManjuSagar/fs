class HaProfileSetup < ActiveRecord::Migration
  def up
    create_table :visit_types, :force => true do |t|
      t.string :visit_type_code, :limit => 20, :null => false
      t.string :visit_type_description, :limit => 50, :null => false
      t.integer :license_type_id, :null => false
    end

    create_table :visit_type_document_defns, :force => true do |t|
      t.boolean :mandatory_flag, :default => false
      t.integer :visit_type_id, :null => false
      t.integer :document_definition_id, :null => false
    end

    create_table :free_form_templates, :force => true do |t|
      t.string :template_short_description, :limit => 100, :null => false
      t.text :template_narrative
      t.string :template_category, :limit => 100
      t.integer :org_id, :null => false
    end

    add_column :document_definitions, :active_flag, :boolean, :default => :false

    create_table :ha_insurance_companies, :force => true do |t|
      t.string :provider_number, :limit => 15, :null => false
      t.integer :health_agency_id, :null => false
      t.integer :insurance_company_id, :null => false
    end

  end

  def down
  end
end
