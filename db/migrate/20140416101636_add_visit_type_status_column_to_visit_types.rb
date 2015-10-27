class AddVisitTypeStatusColumnToVisitTypes < ActiveRecord::Migration
  def change
    add_column :visit_types, :visit_type_status, :string, limit: 1
    VisitType.update_all(:visit_type_status => 'A')
    change_column :visit_types, :visit_type_status, :string, :limit => 1, :null => false
  end
end
