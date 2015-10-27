class AddMedicareBilling < ActiveRecord::Migration
  def up
    create_table :medicare_billings do |t|
      t.integer :patient_treatment_id
      t.integer :treatment_episode_id
      t.integer :type_of_bill
      t.date :bill_date
      t.integer :bill_status
    end
  end

  def down
  end
end
