class RenameColumnDiscipline < ActiveRecord::Migration
  def up
    rename_column :field_staff_credential_types, :discipline_id, :discipline
    change_column :field_staff_credential_types, :discipline, :string, :limit => 50, :null => false
  end

  def down
  end
end
