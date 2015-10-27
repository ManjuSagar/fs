class VisitTypeStateTransitions < ActiveRecord::Migration
  def up
    create_table :visit_type_state_transitions, :force => true do |t|
      t.integer :visit_type_id, :null => false
      t.string :from_state, :limit => 1, :null => false
      t.string :to_state, :limit => 1, :null => false
    end
  end

  def down
  end
end
