class CreateConsultingCompanyHealthAgenciesTable < ActiveRecord::Migration
  def up
    create_table :consulting_company_health_agencies do |t|
      t.integer :consulting_company_id, :null => false
      t.integer :health_agency_id, :null => false
      t.boolean :active, :null => false, :default => false

      t.integer :lock_version
      t.timestamps
    end
  end

  def down
    drop_table :consulting_company_health_agencies
  end
end
