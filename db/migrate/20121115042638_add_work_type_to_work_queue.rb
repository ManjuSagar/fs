class AddWorkTypeToWorkQueue < ActiveRecord::Migration
  def up
     add_column :work_queue, :work_type, :string, :limit => 20, :null => false
  end

  def down
  end
end
