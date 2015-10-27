class VisitTypeOptionalFlag < ActiveRecord::Migration
  def up
    add_column :visit_types, :optional_flag, :boolean, :default => false
  end

  def down
  end
end
