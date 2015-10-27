class SuiteNumberNullable < ActiveRecord::Migration
  def change
    change_column :orgs, :suite_number, :string, limit: 15, null: true
    change_column :health_agencies, :suite_number, :string, limit: 15, null: true
  end
end
