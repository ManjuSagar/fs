class AddDisciplineToCredentialTypes < ActiveRecord::Migration
  def change
    FieldStaffCredentialType.destroy_all
    FieldStaffCredential.destroy_all
    remove_column :field_staff_credential_types, :discipline
    add_column :field_staff_credential_types, :discipline_id, :integer, :null => false

    FieldStaffCredentialType.reset_column_information

    ct_codes = ["0001", "3001", "1001", "2001", "4001", "0123", "0143", "5001"]
    ct_descriptions = ["Professional License", "Driver License", "CPR", "MalPractice Insurance", "Auto Insurance", "Physical",
                       "PPD or Chest X-Ray", "Competency"]
    discipline_codes = ["PT", "PT", "OT", "PT", "PT", "PT", "PT", "SN"]
    expiry_flags = [false, true, false, false, true, false, false, false]

    ct_codes.each_with_index do |code, index|
      d = Discipline.find_by_discipline_code(discipline_codes[index])
      if d.present?
        FieldStaffCredentialType.create!(ct_code: ct_codes[index], ct_description: ct_descriptions[index], :discipline => d, expiry_flag: expiry_flags[index])
      end
    end
  end

end
