class TreamentReqMedEquipRename < ActiveRecord::Migration
  def up
    drop_table :treatment_req_med_equipments
    create_table :treat_req_med_equipments, :force => true do |t|
      t.integer :request_id, :null => false
      t.integer :medical_equipment_id, :null => false
    end
  end

  def down
  end
end
