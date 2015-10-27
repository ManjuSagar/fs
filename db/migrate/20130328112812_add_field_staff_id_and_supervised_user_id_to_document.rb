class AddFieldStaffIdAndSupervisedUserIdToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :field_staff_id, :integer
    add_column :documents, :supervised_user_id, :integer
  end
end
