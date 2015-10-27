class AddPainToTreatmentVitals < ActiveRecord::Migration
  def change
    add_column :treatment_vitals, :pain, :integer
  end

  orgs = Org.where(:org_type => ["FacilityOwner", "HealthAgency"])
  orgs.each do |org|
    unless org.vitals_reference_ranges.empty?
      Org.current = org
      org.vitals_reference_ranges.create!(:vital_sign => "pain", :minimum_value => "0", :maximum_value => "10")
      Org.current = nil
    end
  end
end
