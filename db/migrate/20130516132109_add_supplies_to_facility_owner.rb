class AddSuppliesToFacilityOwner < ActiveRecord::Migration
  def change
    facility_owner  = FacilityOwner.first
    supplies = Supply.find_all_by_org_id(facility_owner.id) if facility_owner
    if supplies and supplies.size == 0
      require 'csv'
      file = File.join(Rails.root, 'static_data', 'supply', 'HHCB_db_7-1-2013.csv')

      CSV.foreach(file, { :headers => true }) do |row|
        Supply.create( {
                           :supply_hcpcs_code => row[0],
                           :supply_description => row[1],
                           :org => facility_owner,
                       })
      end
    end
  end
end
