class MaritalStatusOptional < ActiveRecord::Migration
  def up
    change_column :patient_details, :marital_status, :string, limit: 1, null: true
  end

  def down
  end
end
