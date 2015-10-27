class TreatmentVisitTypes < ActiveRecord::Migration
  def up
    create_table :treatment_visit_types, :force => true do |t|
      t.integer :treatment_id, :null => false
      t.integer :visit_type_id, :null => false
      t.integer :lock_version, :null => false, :default => 0
    end

    add_column :visit_types, :discipline_id, :integer
  end

  def down
  end
end
