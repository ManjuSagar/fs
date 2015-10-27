class DocumentScope < ActiveRecord::Migration
  def up
    rename_column :treatment_requests, :agency_id, :health_agency_id
    add_column :patient_treatments, :health_agency_id, :integer, :null => false
    add_column :documents, :treatment_id, :integer
    add_column :patient_treatments, :agency_contact_user_id, :integer
    add_column :patient_treatments, :treatment_start_date, :date
    add_column :patient_treatments, :treatment_end_date, :date

    Document.all.each {|d| d.update_attribute(:treatment_id, -1)}
    change_column :documents, :treatment_id, :integer, :null => false
  end

  def down
  end
end
