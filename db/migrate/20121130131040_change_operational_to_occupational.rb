class ChangeOperationalToOccupational < ActiveRecord::Migration
  def up

    disciplines = Discipline.where(["discipline_description = ?", "Operational Therapy"])
    disciplines.each do |discipline|
      discipline.discipline_description = "Occupational Therapy"
      discipline.save!
    end

    licenses = LicenseType.all
    licenses.each do |license|
      license.license_type_description = "Occupational Therapist" if license.license_type_description == "Operational Therapist"
      license.license_type_description = "Occupational Therapist Assistant" if license.license_type_description == "Operational Therapist Assistant"
      license.save!
    end
  end

  def down
  end
end
