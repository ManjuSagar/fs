class MoreStaffing < ActiveRecord::Migration
  def up
    create_table :ha_sc_contracts, :force => true do |t|
      t.integer :health_agency_id, :null => false
      t.integer :staffing_company_id, :null => false
      t.datetime :contract_date, :null => false
    end

    create_table :ha_sc_contract_details, :force => true do |t|
      t.integer :contract_id
      t.integer :discipline_id
      t.integer :visit_type_id
    end

    create_table :org_field_staff_visit_types, :force => true do |t|
      t.integer :org_user_id, :null => false
      t.integer :visit_type_id, :null => false
    end
  end

  def down
  end
end
