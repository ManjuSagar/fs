class AgencyOrderTypes < ActiveRecord::Migration
  def change
    add_column :order_types, :org_id, :integer
    add_column :order_types, :system_required, :boolean, :default => true, :null => false
    add_column :order_types, :type_status, :string, :limit => 1
    OrderType.update_all(:type_status => 'A')
    change_column :order_types, :type_status, :string, :limit => 1, :null => false
    add_column :order_types, :disabled_date, :date
    OrderType.reset_column_information

    f = FacilityOwner.first
    Org.current = f
    order_types = OrderType.all

    order_types.each do |order_type|
      order_type.update_column(:org_id, f.id)
    end

    health_agencies = Org.where(:org_type => "HealthAgency")

    health_agencies.each do |ha|
      Org.current = ha
      order_types.each{|order_type|
        ha.order_types.create!(order_type.attributes.reject{|k,v| ["id", "org_id", "lock_version"].include? k.to_s})
      }
    end

    MedicalOrder.all.each do |mo|
      mo_order_type = mo.order_type
      org = mo.treatment.patient.org
      if mo_order_type
        order_type = OrderType.find_by_org_id_and_type_code(org, mo_order_type.type_code).id if mo_order_type.type_code
        mo.update_column(:order_type_id, order_type) if order_type
      end
    end

  end
end
