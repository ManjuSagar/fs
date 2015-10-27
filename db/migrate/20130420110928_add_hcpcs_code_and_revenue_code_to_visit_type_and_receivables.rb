class AddHcpcsCodeAndRevenueCodeToVisitTypeAndReceivables < ActiveRecord::Migration
  def change
    add_column :visit_types, :hcpcs_code, :string
    add_column :visit_types, :revenue_code, :string

    add_column :receivables, :treatment_episode_id, :string
    add_column :receivables, :hcpcs_code, :string
    add_column :receivables, :revenue_code, :string
  end
end
