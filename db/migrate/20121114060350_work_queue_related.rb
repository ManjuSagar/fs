class WorkQueueRelated < ActiveRecord::Migration
  def up
    create_table :work_queue, :force => true do |t|
      t.string :workable_type, :limit => 50, :null => false
      t.integer :workable_id, :null => false
      t.integer :assigned_by_user_id
      t.integer :assigned_to_user_id
      t.timestamp :created_date_time
      t.timestamp :due_date_time
      t.timestamp :completed_date_time
      t.string :work_status, :limit => 2, :null => false
      t.string :work_scopeable_type, :limit => 50
      t.integer :work_scopeable_id
      t.text :comments
    end

    add_column :visit_types, :org_id, :integer, :null => false

    create_table :audit_logs, :force => true do |t|
      t.string :log_type, :limit => 50, :null => false
    end
  end

  def down
  end
end
