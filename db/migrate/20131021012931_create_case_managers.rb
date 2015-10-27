class CreateCaseManagers < ActiveRecord::Migration
  def up
    create_table :insurance_case_managers do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :email
      t.integer :insurance_company_id, null: false

      t.timestamps
    end
  end

  def down
  end
end
