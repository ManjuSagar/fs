require 'csv'
is_production = (ARGV.first && ARGV.first.upcase == "production".upcase)
debug_log is_production ? "For Production: Original Email Ids will be Used" : "For Testing: Original Email Ids replaced with fnpublic+[last_name][number]@gmail.com"
sleep(3)

office_staffs =  CSV.readlines("#{Rails::root}/static_data/agency_setup/office_staff.csv", :headers=>true, skip_blanks: true)
visit_types =  CSV.readlines("#{Rails::root}/static_data/agency_setup/visit_types.csv", :headers=>true, skip_blanks: true)
order_types =  CSV.readlines("#{Rails::root}/static_data/agency_setup/order_types.csv", :headers => true, skip_blanks: true)
attachment_types =  CSV.readlines("#{Rails::root}/static_data/agency_setup/attachment_types.csv", :headers => true, skip_blanks: true)
insurance_companies = CSV.readlines("#{Rails::root}/static_data/agency_setup/insurance_companies.csv", :headers => true, skip_blanks: true)
physicians = CSV.readlines("#{Rails::root}/static_data/agency_setup/physicians.csv", :headers => true, skip_blanks: true)

field_staffs =  CSV.readlines("#{Rails::root}/static_data/agency_setup/field_staff.csv", :headers=>true, skip_blanks: true)
fs_visit_type_rates = CSV.readlines("#{Rails::root}/static_data/agency_setup/fs_rates.csv", :headers=>true, skip_blanks: true)
free_form_templates = CSV.readlines("#{Rails::root}/static_data/agency_setup/templates.csv", :headers=>true, skip_blanks: true)
staffing_companies =  CSV.readlines("#{Rails::root}/static_data/agency_setup/staffing_companies.csv", :headers=>true, skip_blanks: true)
lite_field_staffs =  CSV.readlines("#{Rails::root}/static_data/agency_setup/lite_field_staffs.csv", :headers=>true, skip_blanks: true)

ActiveRecord::Base.transaction do

  def get_email(last_name)
    email = "fnpublic+#{last_name.downcase}@gmail.com"
    l = true
    count = 1
    while l
      user = User.find_by_email email
      if user.present?
        email = "fnpublic+#{last_name.downcase}#{count}@gmail.com"
      else
        l = false
      end
      count += 1
    end
    email
  end

  User.current = User.find_by_email('sa1@fasternotes.com')
  debug_log "Creating HA........."
  email = is_production ? "ihhpie@gmail.com" : get_email("Ybardolaza")
  agency_num = "106"
  health_agency = HealthAgency.new
  health_agency.org_name = "Inland Home Health Providers, Inc."
  health_agency.org_type = "HealthAgency"
  health_agency.org_package = 'P'
  health_agency.week_start_day = 'SUN'
  health_agency.suite_number = "1231"
  health_agency.street_address = "9221 Archibald Ave"
  health_agency.city = "Rancho Cucamonga"
  health_agency.state = 'CA'
  health_agency.zip_code = "91730"
  health_agency.preferred_alert_mode = 'E'
  health_agency.email = email
  health_agency.phone_number = "(909) 948-8731"
  health_agency.fax_number = "(909) 948-8736"
  health_agency.fed_tax_number = "123456789"
  #health_agency.npi_number = "123456789"
  health_agency.primary_contact_first_name = "Rene"
  health_agency.primary_contact_last_name = "Ybardolaza"
  health_agency.primary_contact_email = email
  health_agency.primary_contact_phone_number = "(345) 123-45678"
  health_agency.primary_contact_password = "password"
  health_agency.primary_contact_password_confirmation = "password"
  health_agency.save!

  debug_log "Creating HA Detail........."
  health_agency_detail = health_agency.health_agency_detail || HealthAgencyDetail.new
  health_agency_detail.provider_number = "HH240001913"
  health_agency_detail.cms_cert_number = "058239"
  health_agency_detail.npi_number = "1093854176"
  health_agency_detail.health_agency_id = health_agency.id
  health_agency_detail.submitter_id = "A08123456"
  health_agency_detail.document_definition_set = DocumentDefinitionSet.find_by_set_name("HHA")
  health_agency_detail.document_form_template_set = DocumentFormTemplateSet.find_by_set_name("HHA")
  health_agency_detail.save!

  User.current = User.find_by_email(email)

  debug_log "Creating Office Staffs........."
  office_staffs.each do |os_row|
    role = os_row[0] == "Admin" ? 'A' : 'R'
    user_status = (os_row[5] == 'Y')
    os = OrgStaff.new
    os.role_type = role
    os.first_name = os_row[1]
    os.last_name = os_row[2]
    os.email = is_production ? os_row[3] : get_email(os_row[2])
    os.password = os_row[4]
    os.password_confirmation = os_row[4]
    os.user_status = user_status
    os.org_id = health_agency.id
    os.save!
  end

  VisitType.where(["org_id = ?", health_agency.id]).delete_all
  debug_log "Creating Visit Types........."
  visit_types.each do |vt_row|
    visit_type = VisitType.new
    visit_type.visit_type_code = vt_row[0]
    visit_type.visit_type_description = vt_row[1]
    visit_type.payable_rate = 20.0
    visit_type.discipline = Discipline.find_by_discipline_code(vt_row[3])
    visit_type.sort_order = vt_row[5]
    license_type_codes = vt_row[4].split(', ')
    license_type_codes.each do |license_type_code|
      visit_type.license_types << LicenseType.find_by_license_type_code(license_type_code)
    end

    visit_type.save!

    doc_def_codes = vt_row[6].split(', ')
    doc_def_codes.each do |doc_def_code|
      visit_type_doc_def = visit_type.visit_type_document_definitions.build
      visit_type_doc_def.document_definition = DocumentDefinition.find_by_document_code(doc_def_code)
      visit_type_doc_def.save!
    end

    states_map = {"PE" => :pending_evaluation, "AC" => :active, "HD" => :on_hold, "DC" => :discharged, "AS" => :any_state}
    transitions = {"PE-AC" => vt_row[7], "PE-DC" => vt_row[8], "AC-DC" => vt_row[9], "HD-AC" => vt_row[10],
                   "HD-DC" => vt_row[11], "AS-AS" => vt_row[12]}

    transitions.each do |states, value|
      next unless ['x', 'X'].include?(value)
      next if states.blank?
      visit_type_state_transition = visit_type.state_transitions.build

      from_state, to_state = states.split('-')
      visit_type_state_transition.from_state = states_map[from_state]
      visit_type_state_transition.to_state = states_map[to_state]
      visit_type_state_transition.save!
    end

  end
  debug_log "Creating Field Staffs........."
  field_staffs.each do |fs_row|
    user = User.find_by_email(fs_row[5])
    field_staff = FieldStaff.new
    field_staff.first_name = fs_row[0]
    field_staff.last_name = fs_row[1]
    field_staff.street_address = fs_row[2]
    field_staff.suite_number = fs_row[3]
    field_staff.zip_code = fs_row[4]
    zip_code = ZipCode.find_by_zip_code(fs_row[4])
    field_staff.city = zip_code.locality
    field_staff.state = zip_code.admin_code_1
    field_staff.email = is_production ? fs_row[5] : get_email(fs_row[1])
    field_staff.phone_number = fs_row[6]
    field_staff.phone_number_2 = fs_row[7]
    field_staff.fax_number = fs_row[8]
    field_staff.gender = fs_row[10]
    field_staff.license_number = fs_row[11]
    field_staff.license_type = LicenseType.find_by_license_type_code(fs_row[12])
    languages = fs_row[13].split(',')
    languages.each do |lang|
      language = Language.find_by_language_description(lang.strip)
      field_staff.languages << language unless language.nil?
    end
    field_staff.password = fs_row[9]
    field_staff.password_confirmation = fs_row[9]
    field_staff.save!

    selected_visit_types = fs_visit_type_rates.select {|fs_vt_row| fs_vt_row[4] and fs_row[11] and fs_vt_row[4].strip == fs_row[11].strip}
    selected_visit_types.each do |fs_vt_row|
      visit_type_code = fs_vt_row[2].strip
      visit_type = VisitType.where({org_id: health_agency.id, visit_type_code: visit_type_code}).first
      org_user = OrgUser.find_by_org_id_and_user_id(health_agency.id, field_staff.id)
      next if visit_type.blank?
      next if org_user.blank?
      org_fs_visit_type = OrgFieldStaffVisitType.find_by_visit_type_id_and_org_user_id(visit_type, org_user)
      org_fs_visit_type ||= OrgFieldStaffVisitType.new
      org_fs_visit_type.org_user = org_user
      org_fs_visit_type.visit_type = visit_type
      org_fs_visit_type.visit_rate = fs_vt_row[3].gsub('$', '').strip.to_f
      org_fs_visit_type.save!
    end
  end
  debug_log "Creating Staffing Companies........."
  staffing_companies.each_with_index do |sc_row, index|
    next if sc_row[7].blank?
    staffing_company = StaffingCompany.new
    staffing_company.org_name = sc_row[0]
    staffing_company.suite_number = sc_row[2]
    staffing_company.street_address = sc_row[1]
    staffing_company.city = sc_row[4]
    staffing_company.state = sc_row[5]
    staffing_company.zip_code = sc_row[3]
    staffing_company.email = is_production ? sc_row[6] : get_email("Last Name")
    staffing_company.fed_tax_number = sc_row[7].strip
    staffing_company.phone_number = sc_row[8]
    staffing_company.fax_number = sc_row[9]
    staffing_company.primary_contact_first_name = "First Name"
    staffing_company.primary_contact_last_name = "Last Name"
    staffing_company.primary_contact_email = is_production ? sc_row[6] : get_email("Last Name")
    staffing_company.primary_contact_phone_number = sc_row[8]

    staffing_company.save!

    sc_contract = staffing_company.agency_contracts.first
    next if sc_contract.blank?

    sc_contract.effective_from_date = Date.strptime(sc_row[10], "%d/%m/%Y") unless sc_row[10].blank?

    sc_contract_disciplines = {"PT" => sc_row[11], "OT" => sc_row[12], "ST" => sc_row[13],
                               "MSW" => sc_row[14], "SN" => sc_row[15], "CHHA" => sc_row[16]}

    sc_contract_disciplines.each do |sc_contract_discipline_code, value|
      next if value.blank?
      sc_contract.disciplines << Discipline.find_by_discipline_code(sc_contract_discipline_code)
    end
    sc_contract.save!

    staffs = lite_field_staffs.select{|lfs| lfs[0].strip == sc_row[0].strip }

    staffs.each do |staff_row|
      sc_user = StaffingCompanyUser.new
      sc_user.org = staffing_company
      sc_user.user_status = 'A'
      sc_user.first_name = staff_row[1]
      sc_user.last_name = staff_row[2]
      sc_user.license_number = staff_row[3]
      sc_user.license_type_id = LicenseType.find_by_license_type_code(staff_row[4]).id
      sc_user.user_type = 'LiteFieldStaff'
      sc_user.save!
    end

    visit_types = sc_contract.disciplines.collect{|d| d.visit_types }.flatten.uniq
    visit_types.each do |visit_type|
      visit_type_rate = HaScContractVisitTypeRate.new
      visit_type_rate.staffing_company_contract = sc_contract
      visit_type_rate.visit_type = visit_type
      visit_type_rate.visit_rate = 100
      visit_type_rate.save!
    end
  end

  debug_log "Creating Order Types........."
  order_types.each do |row|
    order_type = OrderType.create(type_code: row[0], type_description: row[1], system_required: row[2])
    health_agency.order_types << order_type
  end

  debug_log "Creating Attachments........."
  health_agency.attachment_types.destroy_all
  attachment_types.each do |row|
    order_type = AttachmentType.create(attachment_code: row[0], attachment_description: row[1], system_required: row[2], org_id: health_agency.id)
    order_type.save!
  end

=begin
  debug_log "Creating Insurance Companies........."
  insurance_companies.each do |row|
    return if row.nil?
    cert_days = row[9]
    cert_days = if cert_days.present?
                  cert_days == "Missing" ? nil : cert_days
                end
    copay = row[10]
    copay = if copay.present?
              copay == "Missing" ? nil : True
            end
    due_days = row[11]
    due_days = if copay.present?
                 copay == "Missing" ? nil : due_days
               end
    phone_number = row[7]
    phone_number = if phone_number.present?
                     list = phone_number.split("-")
                     "(#{list[0]}) #{list[1]}-#{list[2]}"
                   end
    auth_phone_number = row[8]
    auth_phone_number = if auth_phone_number.present?
                          list = auth_phone_number.split("-")
                          "(#{list[0]}) #{list[1]}-#{list[2]}"
                        end
    street_address =  (row[2].present? ? row[2] : "Address Missing")
    suite_number = (row[3].present? ? row[3] : "Missing")

    ins = InsuranceCompany.new(company_name: row[0].strip, company_code: row[1].strip, claim_street_address: street_address,
        claim_suite_number: suite_number, claim_zip_code: row[4][0..4], claim_city: row[5],
        claim_state: row[6], claim_phone_number: phone_number)
    ins.save!
  end
=end

  medicare = health_agency.insurance_companies.where(:company_code => "MEDICARE").first
  InsuranceCompany.apply_visit_type_rates(medicare.id)
  visit_type_rates = medicare.insurance_company_visit_type_rates
  visit_type_rates.update_all("visit_rate = 100")

  debug_log "Creating Physicians........."
  physicians = physicians.each do |row|
    next if row[6].blank?
    physicain_detail = PhysicianDetail.find_by_npi_number(row[6].strip)
    physician = physicain_detail.physician if physicain_detail
    org_physician = OrgPhysician.where(physician_id: physician, org_id: health_agency)

    phone_number = row[7]
    phone_number = if phone_number.present?
                     ph = phone_number.gsub("-", '').strip
                     "(#{ph[0..2]}) #{ph[3..5]}-#{ph[6..9]}"
                   end
    fax_number = row[8]
    fax_number = if fax_number.present?
                   ph = fax_number.gsub("-", '').strip
                   "(#{ph[0..2]}) #{ph[3..5]}-#{ph[6..9]}"
                 end

    pvt_phone_number1 = row[10]
    pvt_phone_number1 = if pvt_phone_number1.present?
                          ph = pvt_phone_number1.gsub("-", '').strip
                          "(#{ph[0..2]}) #{ph[3..5]}-#{ph[6..9]}"
                        end

    pvt_phone_number2 = row[11]
    pvt_phone_number2 = if pvt_phone_number2.present?
                          ph = pvt_phone_number2.gsub("-", '').strip
                          "(#{ph[0..2]}) #{ph[3..5]}-#{ph[6..9]}"
                        end
    email = is_production ? row[9] : get_email(row[1])
    if org_physician.present?
      #physician.first_name = row[0]
      #physician.last_name = row[1]
      #physician.suffix = row[2]
      #physician.street_address = row[3]
      #physician.suite_number = row[4]
      #physician.zip_code = row[5]
      #physician.npi_number = row[6]
      #physician.phone_number = phone_number
      #physician.fax_number = fax_number
      #physician.email = row[9]
      physician.personal_phone_number_1 = pvt_phone_number1
      physician.personal_phone_number_2 = pvt_phone_number2
      physician.save!
    else
      physician = Physician.new
      physician.first_name = row[0]
      physician.last_name = row[1]
      physician.suffix = row[2]
      physician.street_address = row[3]
      physician.suite_number = row[4].strip if row[4].present?
      physician.zip_code = row[5]
      physician.npi_number = row[6]
      physician.phone_number = phone_number
      physician.fax_number = fax_number
      physician.email = email
      physician.personal_phone_number_1 = pvt_phone_number1
      physician.personal_phone_number_2 = pvt_phone_number2
      physician.save!
    end
  end

  debug_log "Creating Free Form Templates........."
  free_form_templates.each do |template|
    free_form_template = FreeFormTemplate.new
    free_form_template.template_short_description = template[0]
    free_form_template.template_narrative = template[1]
    free_form_template.save!
  end

end






