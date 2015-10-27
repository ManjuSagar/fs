class AddNewFieldstaff < ActiveRecord::Migration
  def up
    org = FacilityOwner.first
    Org.current = org
    fs1 = FieldStaff.new({:email => "fnpublic+monica@gmail.com", :password => "test1234",
                          :password_confirmation => "test1234", :first_name => "Monica", :last_name => "Seles", :suite_number => "7659",
                          :street_address => "Coney Island Ave.", :city => "Los Angeles", :state => "CA", :zip_code => '90023'})
    fs1.gender = 'F'
    fs1.sign_password = "test1234"
    fs1.sign_password_confirmation = "test1234"
    fs1.license_type = LicenseType.find_by_license_type_code("RN")
    fs1.license_number = "55555"
    fs1.languages <<  Language.find_by_language_code("EN")
    fs1.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Driver License").id,
                           :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/driving_license.pdf")})
    fs1.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Competency").id,
                           :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/auto_insurance.pdf")})
    fs1.save!


    fs2 = FieldStaff.new({:email => "fnpublic+martin@gmail.com", :password => "test1234",
                          :password_confirmation => "test1234", :first_name => "Martin", :last_name => "Billy", :suite_number => "5971",
                          :street_address => "West Wood Island Ave.", :city => "Los Angeles", :state => "CA", :zip_code => '90023'})
    fs2.gender = 'M'
    fs2.sign_password = "test1234"
    fs2.sign_password_confirmation = "test1234"
    fs2.license_type = LicenseType.find_by_license_type_code("LVN")
    fs2.license_number = "66666"
    fs2.languages <<  Language.find_by_language_code("EN")
    fs2.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Driver License").id,
                           :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/driving_license.pdf")})
    fs2.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Competency").id,
                           :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/auto_insurance.pdf")})
    fs2.save!


    fs3 = FieldStaff.new({:email => "fnpublic+pete@gmail.com", :password => "test1234",
                          :password_confirmation => "test1234", :first_name => "Pete", :last_name => "Sampras", :suite_number => "8329",
                          :street_address => "1656 Union Street", :city => "Los Angeles", :state => "CA", :zip_code => '90012'})
    fs3.gender = 'M'
    fs3.sign_password = "test1234"
    fs3.sign_password_confirmation = "test1234"
    fs3.license_type = LicenseType.find_by_license_type_code("ST")
    fs3.license_number = "77777"
    fs3.languages <<  Language.find_by_language_code("EN")
    fs3.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Driver License").id,
                           :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/driving_license.pdf")})
    fs3.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Auto Insurance").id,
                           :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/auto_insurance.pdf")})
    fs3.save!


    fs4 = FieldStaff.new({:email => "fnpublic+andre@gmail.com", :password => "test1234",
                          :password_confirmation => "test1234", :first_name => "Andre", :last_name => "Agassi", :suite_number => "8329",
                          :street_address => "6901 McKinley Avenue", :city => "Los Angeles", :state => "CA", :zip_code => '90012'})
    fs4.gender = 'M'
    fs4.sign_password = "test1234"
    fs4.sign_password_confirmation = "test1234"
    fs4.license_type = LicenseType.find_by_license_type_code("STA")
    fs4.license_number = "88888"
    fs4.languages <<  Language.find_by_language_code("EN")
    fs4.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Driver License").id,
                           :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/driving_license.pdf")})
    fs4.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Auto Insurance").id,
                           :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/auto_insurance.pdf")})
    fs4.save!


    fs5 = FieldStaff.new({:email => "fnpublic+latin@gmail.com", :password => "test1234",
                          :password_confirmation => "test1234", :first_name => "Latin", :last_name => "Hewitt", :suite_number => "7459",
                          :street_address => "1419 Westwood Blvd", :city => "Los Angeles", :state => "CA", :zip_code => '90024'})
    fs5.gender = 'M'
    fs5.sign_password = "test1234"
    fs5.sign_password_confirmation = "test1234"
    fs5.license_type = LicenseType.find_by_license_type_code("MSW")
    fs5.license_number = "99999"
    fs5.languages <<  Language.find_by_language_code("EN")
    fs5.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Driver License").id,
                           :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/driving_license.pdf")})
    fs5.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Auto Insurance").id,
                           :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/auto_insurance.pdf")})
    fs5.save!

    fs6 = FieldStaff.new({:email => "fnpublic+jimmy@gmail.com", :password => "test1234",
                           :password_confirmation => "test1234", :first_name => "Jimmy", :last_name => "Conors", :suite_number => "1178",
                           :street_address => "8032 W 3rd St", :city => "Los Angeles", :state => "CA", :zip_code => '90048'})
    fs6.gender = 'M'
    fs6.sign_password = "test1234"
    fs6.sign_password_confirmation = "test1234"
    fs6.license_type = LicenseType.find_by_license_type_code("CHHA")
    fs6.license_number = "91919"
    fs6.languages <<  Language.find_by_language_code("EN")
    fs6.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Driver License").id,
                            :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/driving_license.pdf")})
    fs6.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Auto Insurance").id,
                            :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/auto_insurance.pdf")})
    fs6.save!
  end

  def down
  end
end
