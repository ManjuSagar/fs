class AddVisitEntryType < ActiveRecord::Migration
  def up
    add_column :treatment_visits, :visit_entry_type, :string, :limit => 1, :null => false, :default => 'E'
  end

  def down
  end
end
