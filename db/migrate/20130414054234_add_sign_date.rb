class AddSignDate < ActiveRecord::Migration
  def change
    add_column :treatment_visits, :fs_sign_date, :date
    add_column :treatment_visits, :supervised_user_sign_date, :date
    add_column :treatment_visits, :os_sign_date, :date

    add_column :documents, :fs_sign_date, :date
    add_column :documents, :supervised_user_sign_date, :date
    add_column :documents, :os_sign_date, :date

    add_column :communication_notes, :created_user_sign_date, :date

    add_column :medical_orders, :os_sign_date, :date
  end
end
