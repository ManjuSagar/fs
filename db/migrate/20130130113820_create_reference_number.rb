class CreateReferenceNumber < ActiveRecord::Migration
  def change

    drop_table :medical_order_sequences

    create_table :reference_numbers do |t|
      t.integer :org_id, :null => false
      t.date :reference_date, :null => false
      t.integer :sequence, :null => false, :default => 0
      t.string :reference_type, :null => false
      t.integer :lock_version
    end

    unless MedicalOrder.attribute_names.include?("order_reference")
      add_column :medical_orders, :order_reference, :string
      MedicalOrder.update_all(:order_reference => "1")
    end

    change_column :medical_orders, :order_reference, :string

    add_column :patient_details, :patient_reference, :string
    PatientDetail.update_all(:patient_reference => "1")
    change_column :patient_details, :patient_reference, :string, :null => false

    add_column :patient_treatments, :treatment_reference, :string
    PatientTreatment.update_all(:treatment_reference => "1")
    change_column :patient_treatments, :treatment_reference, :string, :null => false

  end
end
