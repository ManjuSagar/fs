class CreateTableOrgPhysician < ActiveRecord::Migration
  def up
    create_table :org_physicians do |t|
      t.integer :org_id, :null =>false
      t.integer :physician_id, :null => false
      t.string :contact_1
      t.string :contact_2
    end
  end

  def down
  end
end
