class AddMrNumberStartWithColumnToHealthAgencyDetails < ActiveRecord::Migration
  def change
    add_column :health_agency_details, :mr_num_start_with, :string
  end
end
