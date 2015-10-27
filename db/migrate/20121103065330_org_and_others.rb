class OrgAndOthers < ActiveRecord::Migration
  def up
    add_column :orgs, :phone_number, :string, :limit => 15
    add_column :orgs, :fax_number, :string, :limit => 15
    add_column :orgs, :org_detail_id, :integer

    add_column :users, :user_detail_id, :integer
    add_column :users, :suite_number, :string, :limit => 15
    add_column :users, :street_address, :string, :limit => 50
    add_column :users, :city, :string, :limit => 50
    add_column :users, :state, :string, :limit => 2
    add_column :users, :zip_code, :string, :limit => 10
    add_column :users, :phone_number, :string, :limit => 15

    create_table :health_agency_details, :force => true do |t|
      t.string :provider_number, :limit => 100
      t.string :agency_type, :limit => 1
    end

    create_table :patients, :force => true do |t|
      t.string :first_name, :limit => 50, :null => false
      t.string :last_name, :limit => 50, :null => false
      t.string :gender, :limit => 1, :null => false
      t.date  :dob, :null => false
      t.string :marital_status, :limit => 1
      t.string :ssn, :limit => 9
      t.string :suite_number, :limit => 15
      t.string :street_address, :limit => 50
      t.string :city, :limit => 50
      t.string :state, :limit => 2
      t.string :zip_code, :limit => 10
      t.string :email, :limit => 100
      t.string :phone_number, :limit => 15
      t.string :languages, :limit => 50
      t.integer :patient_detail_id
    end

    create_table :patient_details, :force => true do |t|
      t.string :medicare_number, :limit => 50
      t.string :medicaid_number, :limit => 50
      t.integer :height
      t.string :height_unit, :limit => 1
      t.integer :weight
      t.string :weight_unit, :limit => 1
    end

    create_table :treatment_requests, :force => true do |t|
      t.integer :patient_id, :null => false
      t.timestamp :request_date, :null => false
      t.string :request_status, :limit => 1, :null => false, :default => 'N'
      t.integer :agency_id, :null => false
      t.integer :created_user_id, :null => false
      t.string :preferred_language, :limit => 2
      t.boolean :lang_mandatory_flag
      t.string :preferred_gender, :limit => 1
      t.boolean :gender_mandatory_flag
      t.text :special_instructions
      t.boolean :si_mandatory_flag
      t.text :known_allergies
      t.text :reason_for_therapy
      t.text :restrictions
      t.integer :agency_contact_user_id
      t.integer :approved_agency_user_id
      t.timestamp :approved_date_time
    end

    create_table :treat_req_disciplines, :force => true do |t|
      t.integer :request_id, :null => false
      t.integer :discipline_id, :null => false
    end

    create_table :patient_treatments, :force => true do |t|
      t.integer :treatment_request_id, :null => false
      t.string :treatment_status, :null => false, :default => 'N'
    end

    create_table :treatment_physicians, :force => true do |t|
      t.integer :treatment_id, :null => false
      t.integer :physician_id, :null => false
      t.boolean :primary_referral_flag
      t.boolean :require_cc_flag
    end

    create_table :physician_details, :force => true do |t|
      t.string :npi_number, :limit => 15, :null => false
    end

    create_table :treatment_disciplines, :force => true do |t|
      t.integer :treatment_id, :null => false
      t.integer :discipline_id, :null => false
      t.string :treatment_status, :null => false, :default => 'N'
    end
  end

  def down

  end
end
