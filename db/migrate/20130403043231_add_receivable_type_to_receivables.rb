class AddReceivableTypeToReceivables < ActiveRecord::Migration
  def change
    Receivable.destroy_all
    add_column :receivables, :receivable_type, :string, :limit => 1, :null => false
    change_column :receivables, :source_type, :string, :null => true
    change_column :receivables, :source_id, :integer, :null => true
    remove_column :receivables, :treatment_id
  end
end
