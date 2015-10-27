class AddDataColumnToHealthAgencyDetails < ActiveRecord::Migration
  def change
    add_column :health_agency_details, :data, :text
  end
end
