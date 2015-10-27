class AddSuppliesToExistingOrgs < ActiveRecord::Migration
  def change
    orgs = HealthAgency.all
    orgs.each do |org|
      supplies = Supply.find_all_by_org_id(org.id)
      if supplies.size == 0
        require 'csv'
        file = File.join(Rails.root, 'static_data', 'supply', 'HHCB_db_7-1-2013.csv')
        CSV.foreach(file, { :headers => true }) do |row|
          Supply.create( {
                             :supply_hcpcs_code => row[0],
                             :supply_description => row[1],
                             :org => org,
                         })
        end
      end
    end
  end
end
