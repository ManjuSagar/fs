class CreateTableAuthorizationTrackings < ActiveRecord::Migration
  def self.up
    create_table :authorization_trackings do |t|

      t.integer :patient_id

      t.integer :treatment_episode_id

      t.integer :insurance_company_id

      t.integer :discipline_id

      t.integer :field_staff_id

      t.integer :insurance_case_manager_id

      t.string :visit_count

      t.string :patient_number

      t.date :start_date

      t.date :end_date

      t.string :authorization_number

      t.text :special_instructions

      t.text :internal_comments

      t.timestamps
    end
  end

  def self.down
    drop_table :authorization_trackings
  end

end
