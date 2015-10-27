class ReferralToAdmission < ActiveRecord::Migration
  def up
    create_table :medical_equipments, :force => true do |t|
      t.string :equipment_name, :limit => 50, :null => false
    end

    create_table :treatment_req_med_equipments, :force => true do |t|
      t.integer :treatment_request_id, :null => false
      t.integer :medical_equipment_id, :null => false
    end

    create_table :languages, :force => true do |t|
      t.integer :language_code, :limit => 2, :null => false
      t.integer :language_description, :limit => 50, :null => false
    end

    create_table :patient_languages, :force => true do |t|
      t.integer :patient_id, :null => false
      t.integer :language_id, :null => false
    end

    create_table :patient_caregivers, :force => true do |t|
      t.integer :patient_id, :null => false
      t.integer :caregiver_id, :null => false
      t.string :relation_to_patient, :limit => 15, :null => false
      t.boolean :primary_flat, :null => false
    end

    add_column :treatment_requests, :referred_physician_id, :integer

    create_table :contact_types, :force => true do |t|
      t.string :type_name, :limit => 30, :null => false
    end

  end


  def down
  end
end
