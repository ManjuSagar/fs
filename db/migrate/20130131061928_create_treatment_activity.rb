class CreateTreatmentActivity < ActiveRecord::Migration
  def change
    create_table :treatment_activities do |t|
      t.integer :treatment_id, :null => false
      t.integer :discipline_id
      t.datetime :activity_date, :null =>  false
      t.integer :created_user_id, :null => false
      t.string :activity_reason_code
      t.text :activity_remarks
      t.integer :activity_type_id, :null => false
      t.integer :lock_version
    end

    create_table :activity_types do |t|
      t.string :activity_type_code, :null =>  false, :limit => 50
      t.string :activity_type_description, :null => false

      t.timestamps
    end

    remove_column :patient_treatments, :discharge_date, :discharge_reason, :discharge_remarks
    remove_column :treatment_disciplines, :discharge_date, :discharge_reason, :discharge_remarks
  end
end
