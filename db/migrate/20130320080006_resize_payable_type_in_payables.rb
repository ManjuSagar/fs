class ResizePayableTypeInPayables < ActiveRecord::Migration
  def up
    Payable.where(['payable_type is NULL']).update_all "payable_type = 'A'"
    change_column :payables, :payable_type, :string, :limit => 2, :null => false
  end
  
  def down
    change_column :payables, :payable_type, :string, :limit => 3
  end
end
