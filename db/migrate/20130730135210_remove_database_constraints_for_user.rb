class RemoveDatabaseConstraintsForUser < ActiveRecord::Migration
  def change
    change_column :users, :first_name, :string, :null => true
    change_column :users, :last_name, :string, :null => true
    change_column :patient_details, :dob, :date, :null => true
    change_column :patient_details, :ssn, :string, :null => true
    change_column :users, :gender, :string, :null => true
    add_column :users, :draft_status, :boolean, :default => false
  end
end
