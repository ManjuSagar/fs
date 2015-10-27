# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create!([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create!(name: 'Emanuel', city: cities.first)


# default users creation and assigning roles to users
if Rails.env == "development"

  #Disciplines and License Types
  Discipline.destroy_all

  Discipline.create!(discipline_code: "PT", discipline_description: "Physical Therapy", sort_order: 2)
  Discipline.create!(discipline_code: "OT", discipline_description: "Occupational Therapy", sort_order: 3)
  Discipline.create!(discipline_code: "ST", discipline_description: "Speech Therapy", sort_order: 4)
  Discipline.create!(discipline_code: "SN", discipline_description: "Skilled Nursing", sort_order: 1)
  Discipline.create!(discipline_code: "MSW", discipline_description: "Social Worker", sort_order: 5)
  Discipline.create!(discipline_code: "CHHA", discipline_description: "Certified Home Health Agency", sort_order: 6)

  LicenseType.destroy_all

  LicenseType.create!(license_type_code: "PT", license_type_description: "Physical Therapist",
                     discipline_id: Discipline.find_by_discipline_code("PT").id, independent_flag: true)
  LicenseType.create!(license_type_code: "PTA", license_type_description: "Physical Therapist Assistant",
                     discipline_id: Discipline.find_by_discipline_code("PT").id, independent_flag: false)
  LicenseType.create!(license_type_code: "OT", license_type_description: "Occupational Therapist",
                     discipline_id: Discipline.find_by_discipline_code("OT").id, independent_flag: true)
  LicenseType.create!(license_type_code: "OTA", license_type_description: "Occupational Therapist Assistant",
                     discipline_id: Discipline.find_by_discipline_code("OT").id, independent_flag: false)
  LicenseType.create!(license_type_code: "ST", license_type_description: "Speech Therapist",
                     discipline_id: Discipline.find_by_discipline_code("ST").id, independent_flag: true)
  LicenseType.create!(license_type_code: "STA", license_type_description: "Speech Therapist Assistant",
                     discipline_id: Discipline.find_by_discipline_code("ST").id, independent_flag: false)
  LicenseType.create!(license_type_code: "SN", license_type_description: "Skilled Nurse",
                     discipline_id: Discipline.find_by_discipline_code("SN").id, independent_flag: true)
  LicenseType.create!(license_type_code: "SNA", license_type_description: "Skilled Nurse Assistant",
                     discipline_id: Discipline.find_by_discipline_code("SN").id, independent_flag: false)
  LicenseType.create!(license_type_code: "MSW", license_type_description: "Social Worker",
                     discipline_id: Discipline.find_by_discipline_code("MSW").id, independent_flag: true)
  LicenseType.create!(license_type_code: "CHHA", license_type_description: "Care Planer",
                     discipline_id: Discipline.find_by_discipline_code("CHHA").id, independent_flag: true)

Org.destroy_all
OrgContact.destroy_all
User.destroy_all

facility_owner = FacilityOwner.create!({"org_name"=>"Fasternotes Facility", "org_package"=>"P", "week_start_day"=>"MON",
            "suite_number"=>"113", "street_address"=>"North Center Dr.", "city"=>"New York", "state"=>"NY",
            "zip_code"=>"11203", "email"=>"admin@fasternotes.com", "preferred_alert_mode"=>"E", "notes"=>"",
            "phone_number"=>"(212) 403-1212", "fax_number"=>"(212) 403-1213",
            :primary_contact_first_name => "William",
            :primary_contact_last_name => "Dawon", :primary_contact_phone_number => "(212) 403-1109",
            :primary_contact_email => "william@fasternotes.com.com", :primary_contact_password => "test1234",
            :primary_contact_password_confirmation => "test1234", :fed_tax_number => "123456799"}, {:without_protection => true})

users = ['sa1', 'sa2']
first_names = ["Emma", "Tina",]
last_names = ["Will", "Miller"]
users.each_with_index do |role, i|
  user = SuperAdmin.create!(first_name: first_names[i], last_name: last_names[i], email: "#{role}@fasternotes.com", password: "test1234", password_confirmation: "test1234")
  facility_owner.users << user
end

org1 = Org.create!({"org_name"=>"GoodHealth Home Care", "org_type"=>"HealthAgency", "org_package"=>"P", "week_start_day"=>"MON",
           "suite_number"=>"113", "street_address"=>"North Center Dr.", "city"=>"New York", "state"=>"NY",
           "zip_code"=>"11203", "email"=>"admin@ghh.com", "preferred_alert_mode"=>"E", "notes"=>"test",
           "phone_number"=>"(212) 403-4212", "fax_number"=>"(212) 403-4213", :primary_contact_first_name => "John",
           :primary_contact_last_name => "Doe", :primary_contact_phone_number => "(212) 403-4109",
           :primary_contact_email => "john@goodhealth.com", :primary_contact_password => "test1234",
           :primary_contact_password_confirmation => "test1234", :fed_tax_number => "123456789"}, {:without_protection => true})
   org_user = org1.users.first
   org_user.sign_password = "test1234"
  org_user.sign_password_confirmation = "test1234"
  org_user.save!

org2 = Org.create!({"org_name"=>"Twinkle Health", "org_type"=>"HealthAgency", "org_package"=>"P", "week_start_day"=>"MON",
            "suite_number"=>"245", "street_address"=>"Kensington Ave.", "city"=>"New York", "state"=>"NY",
            "zip_code"=>"11203", "email"=>"admin@ghh.com", "preferred_alert_mode"=>"E", "notes"=>"test",
            "phone_number"=>"(212) 403-1512", "fax_number"=>"(212) 403-1513", :primary_contact_first_name => "Steve",
            :primary_contact_last_name => "Hong", :primary_contact_phone_number => "(212) 403-1509",
            :primary_contact_email => "steve@th.com", :primary_contact_password => "test1234",
            :primary_contact_password_confirmation => "test1234", :fed_tax_number => "123456999"}, {:without_protection => true})
  org_user2 = org2.users.first
  org_user2.sign_password = "test1234"
  org_user2.sign_password_confirmation = "test1234"
  org_user2.save!

#Initial Documents

  org = FacilityOwner.first

  template_names = ["PTEvaluation", "PTFollowup", "PTDischarge", "OTEvaluation", "OTFollowup", "OTDischarge",
                    "SNEvaluation", "SNFollowup", "SNDischarge", "STEvaluation", "STFollowup", "STDischarge",
                    "MSWEvaluation", "MSWFollowup", "MSWDischarge", "PlanOfCare485", "SOC Oasis", "SOC Oasis C1", "Adhoc", "Oasis ROC",
                    "Oasis RR", "Oasis OF", "Oasis TIFPND", "Oasis TIFPD", "Oasis DAH", "Oasis DFA", "CHHAEvaluation", "CHHAFollowup", "SuperVisorVisit"]

  template_descriptions = ["PT Evaluation", "PT Followup", "PT Discharge", "OT Evaluation", "OT Followup", "OT Discharge",
                           "SN Evaluation", "SN Followup", "SN Discharge", "ST Evaluation", "ST Followup", "ST Discharge",
                           "MSW Evaluation", "MSW Followup", "MSW Discharge", "Plan Of Care 485", "Oasis Evaluation", "OASIS Evaluation C1", "Adhoc",
                           "Oasis Resumption Of Care", "Oasis Recertification", "Oasis Other Followup", "Oasis Transferred to an inpatient facility - patient not discharged from agency",
                           "Oasis Transferred to an inpatient facility - patient discharged from agency", "Oasis Death at Home", "Oasis Discharge from agency", "CHHA Evaluation", "CHHA Followup", "Super Visor Visit"]

  document_class_names = ["PTEvaluationForm", "PTFollowUpForm", "PTDischargeForm", "OTEvaluationForm", "OTFollowUpForm", "OTDischargeForm",
                          "SNEvaluationForm", "SNFollowUpForm", "SNDischargeForm", "STEvaluationForm", "STFollowUpForm", "STDischargeForm",
                          "MSWEvaluationForm", "MSWFollowUpForm", "MSWDischargeForm", "PlanOfCareForm", "OasisEvalForm","OasisEvalFormC1","AdhocDocumentForm",
                          "OasisResumptionOfCareForm", "OasisRecertificationForm", "OasisOtherFollowupForm", "OasisTransferredPatientWithoutDischargeForm",
                          "OasisTransferredPatientWithDischargeForm", "OasisDeathAtHomeForm", "OasisDischargeFromAgencyForm", "ChhaCarePlanForm", "CHHAFollowUpForm", "SuperVisoryVisitForm"]

  report_file_names = ["generic_template", "generic_template", "generic_template", "generic_template", "generic_template", "generic_template",
                       "generic_template", "generic_template", "generic_template", "generic_template", "generic_template", "generic_template",
                       "msw_eval", "generic_template", "generic_template", "plan_of_care", "oasis_generic_template","oasis_generic_template", "adhoc_document",
                       "oasis_roc", "oasis_rr", "oasis_of", "oasis_tifpnd", "oasis_tifpd", "oasis_dah", "oasis_dfa", "chha_eval", "chha_followup", "super_visor_visit"]

  document_codes = ["PT_EVAL", "PT_FOLLOWUP", "PT_DISCHARGE", "OT_EVAL", "OT_FOLLOWUP", "OT_DISCHARGE",
                    "SN_EVAL", "SN_FOLLOWUP", "SN_DISCHARGE", "ST_EVAL", "ST_FOLLOWUP", "ST_DISCHARGE",
                    "MSW_EVAL", "MSW_FOLLOWUP", "MSW_DISCHARGE", "PLAN_OF_CARE_485", "SOC_OASIS", "SOC_OASIS_C1", "ADHOC",
                    "OASIS_ROC", "OASIS_RR", "OASIS_OF", "OASIS_TIFPND", "OASIS_TIFPD", "OASIS_DAH", "OASIS_DFA", "CHHA_EVAL", "CHHA_FOLLOWUP", "SUPERVISOR_VISIT"]

  document_names = ["PT Evaluation", "PT Followup", "PT Discharge", "OT Evaluation", "OT Followup", "OT Discharge",
                     "SN Evaluation", "SN Followup", "SN Discharge", "ST Evaluation", "ST Followup", "ST Discharge",
                     "MSW Evaluation", "MSW Followup", "MSW Discharge", "Plan Of Care (485)", "OASIS Evaluation", "OASIS Evaluation C1", "Adhoc",
                     "Oasis Resumption Of Care", "Oasis Recertification", "Oasis Other Followup", "Oasis Transferred to an inpatient facility - patient not discharged from agency",
                     "Oasis Transferred to an inpatient facility - patient discharged from agency", "Oasis Death at Home", "Oasis Discharge from agency", "CHHA Evaluation", "CHHA Followup", "Super Visor Visit"]

  DocumentDefinition.destroy_all
  DocumentFormTemplate.destroy_all
  DocumentDefinitionSet.all.each do |set|
    set.document_definitions.clear
  end
  DocumentDefinitionSet.destroy_all
  DocumentFormTemplateSet.all.each do |set|
    set.document_form_templates.clear
  end
  DocumentFormTemplateSet.destroy_all

  doc_set = DocumentDefinitionSet.create!(set_name: "Default", set_description: "Default Documents Set")
  tpl_set = DocumentFormTemplateSet.create!(set_name: "Default", set_description: "Default Form Templates Set")
  template_names.each_with_index do |name, index|
    tpl = DocumentFormTemplate.create!(template_name: template_names[index], template_description: template_descriptions[index],
                              document_class_name: document_class_names[index], status: "A", report_file_name: report_file_names[index])

    doc = DocumentDefinition.create!(document_code: document_codes[index], document_name: document_names[index], document_form_template_id: tpl.id,
                                    org_id: facility_owner.id, payable_rate: 20)
    tpl_set.document_form_templates << tpl
    doc_set.document_definitions << doc
  end

# Field Staff Credential Type

 FieldStaffCredentialType.destroy_all

  FieldStaffCredentialType.create!(ct_code: "0001", ct_description: "Professional License", discipline: Discipline.find_by_discipline_code("PT"), expiry_flag: false)
  FieldStaffCredentialType.create!(ct_code: "3001", ct_description: "Driver License", discipline: Discipline.find_by_discipline_code("PT"), expiry_flag: true)
  FieldStaffCredentialType.create!(ct_code: "1001", ct_description: "CPR", discipline: Discipline.find_by_discipline_code("OT"), expiry_flag: false)
  FieldStaffCredentialType.create!(ct_code: "2001", ct_description: "MalPractice Insurance", discipline: Discipline.find_by_discipline_code("PT"), expiry_flag: false)
  FieldStaffCredentialType.create!(ct_code: "4001", ct_description: "Auto Insurance", discipline: Discipline.find_by_discipline_code("PT"), expiry_flag: true)
  FieldStaffCredentialType.create!(ct_code: "0123", ct_description: "Physical", discipline: Discipline.find_by_discipline_code("PT"), expiry_flag: false)
  FieldStaffCredentialType.create!(ct_code: "0143", ct_description: "PPD or Chest X-Ray", discipline: Discipline.find_by_discipline_code("PT"), expiry_flag: false)
  FieldStaffCredentialType.create!(ct_code: "5001", ct_description: "Competency", discipline: Discipline.find_by_discipline_code("SN"), expiry_flag: false)



# Staffing Company Credential Type

StaffingCompanyCredentialType.destroy_all

  StaffingCompanyCredentialType.create!(ct_code: "0001", ct_description: "Professional License", expiry_flag: false)
  StaffingCompanyCredentialType.create!(ct_code: "3001", ct_description: "Driver License", expiry_flag: true)
  StaffingCompanyCredentialType.create!(ct_code: "1001", ct_description: "CPR", expiry_flag: false)
  StaffingCompanyCredentialType.create!(ct_code: "2001", ct_description: "MalPractice Insurance", expiry_flag: false)
  StaffingCompanyCredentialType.create!(ct_code: "4001", ct_description: "Auto Insurance", expiry_flag: true)
  StaffingCompanyCredentialType.create!(ct_code: "0123", ct_description: "Physical", expiry_flag: false)
  StaffingCompanyCredentialType.create!(ct_code: "0143", ct_description: "PPD or Chest X-Ray", expiry_flag: false)
  StaffingCompanyCredentialType.create!(ct_code: "5001", ct_description: "Competency", expiry_flag: false)

#Vital Signs Reference Ranges
  
  VitalsReferenceRange.destroy_all
  Org.current = org

  VitalsReferenceRange.create!({:org_id => org.id, :vital_sign => "systolic_bp", :minimum_value => "90", :maximum_value => "140", :last_updated_datetime => Time.now})
  VitalsReferenceRange.create!({:org_id => org.id, :vital_sign => "diastolic_bp", :minimum_value => "100", :maximum_value => "150", :last_updated_datetime => Time.now})
  VitalsReferenceRange.create!({:org_id => org.id, :vital_sign => "heart_rate", :minimum_value => "72", :maximum_value => "80", :last_updated_datetime => Time.now})
  VitalsReferenceRange.create!({:org_id => org.id, :vital_sign => "respiration_rate", :minimum_value => "70", :maximum_value => "80", :last_updated_datetime => Time.now})
  VitalsReferenceRange.create!({:org_id => org.id, :vital_sign => "temperature_in_fht", :minimum_value => "96", :maximum_value => "102", :last_updated_datetime => Time.now})
  VitalsReferenceRange.create!({:org_id => org.id, :vital_sign => "fasting_blood_sugar", :minimum_value => "100", :maximum_value => "200", :last_updated_datetime => Time.now})
  VitalsReferenceRange.create!({:org_id => org.id, :vital_sign => "random_blood_sugar", :minimum_value => "100", :maximum_value => "200", :last_updated_datetime => Time.now})
  VitalsReferenceRange.create!({:org_id => org.id, :vital_sign => "weight_in_lbs", :minimum_value => "5", :maximum_value => "50", :last_updated_datetime => Time.now})
  VitalsReferenceRange.create!({:org_id => org.id, :vital_sign => "oxygen_saturation", :minimum_value => "73", :maximum_value => "95", :last_updated_datetime => Time.now})
  VitalsReferenceRange.create!({:org_id => org.id, :vital_sign => "pain", :minimum_value => "0", :maximum_value => "10", :last_updated_datetime => Time.now})

  #Visit Types

  VisitType.destroy_all
  VisitTypeDocumentDefinition.destroy_all
  LicenseTypesVisitType.delete_all

  Org.current = org

  vt_doc_names = ["PT Evaluation", "PT Followup", "PT Discharge", "OT Evaluation", "OT Followup", "OT Discharge",
                               "SN Evaluation", "SN Followup", "SN Discharge", "ST Evaluation", "ST Followup", "ST Discharge",
                               "MSW Evaluation", "MSW Followup", "MSW Discharge", "CHHA Evaluation", "CHHA Followup", "SOC Oasis"]
  vt_docs = ["Evaluation", "Followup", "Discharge", "Evaluation", "Followup", "Discharge",
                  "Evaluation", "Followup", "Discharge", "Evaluation", "Followup", "Discharge",
                  "Evaluation", "Followup", "Discharge", "Evaluation", "Followup"]

  visit_type_codes = ["PT_EVAL", "PT_FOLLOWUP", "PT_DISCHARGE", "OT_EVAL", "OT_FOLLOWUP", "OT_DISCHARGE",
                    "SN_EVAL", "SN_FOLLOWUP", "SN_DISCHARGE", "ST_EVAL", "ST_FOLLOWUP", "ST_DISCHARGE",
                    "MSW_EVAL", "MSW_FOLLOWUP", "MSW_DISCHARGE", "CHHA_EVAL", "CHHA_FOLLOWUP"]

  license_visit_types = [['PT'],['PT','PTA'],['PT'],['OT'],['OT', 'OTA'],['OT'],['SN'], ['SN','SNA'], ['SN'],['ST'],['ST','STA'],
                         ['ST'],['MSW'],['MSW'],['MSW'],['CHHA'],['CHHA']]

  visit_type_codes.each_with_index do |code, index|
    discipline_code = code.split("_").first.upcase
    vt = VisitType.new({:visit_type_code => code, :visit_type_description => vt_docs[index], :discipline => Discipline.find_by_discipline_code(discipline_code),
                     :payable_rate => "10", :org_id => org.id, :optional_flag => (vt_docs[index] == "Discharge")? true : false,
                     :sort_order => ((vt_docs[index]== "Evaluation") ? 1: (vt_docs[index] == "Followup" ? 2 : 3))})

    vt.save(:validate => false)
    VisitTypeDocumentDefinition.create!({:mandatory_flag => true, :visit_type_id => vt.id,
                                               :document_definition => DocumentDefinition.find_by_document_name(vt_doc_names[index])})
    #Oasis documents
    if vt_docs[index] == "Evaluation"
      vt.visit_type_document_definitions.create!({:mandatory_flag => false, :document_definition => DocumentDefinition.find_by_document_code("SOC_OASIS")})
      vt.visit_type_document_definitions.create!({:mandatory_flag => false, :document_definition => DocumentDefinition.find_by_document_code("OASIS_ROC")})
      vt.visit_type_document_definitions.create!({:mandatory_flag => false, :document_definition => DocumentDefinition.find_by_document_code("OASIS_RR")})
    elsif vt_docs[index] == "Followup"
      vt.visit_type_document_definitions.create!({:mandatory_flag => false, :document_definition => DocumentDefinition.find_by_document_code("OASIS_RR")})
      vt.visit_type_document_definitions.create!({:mandatory_flag => false, :document_definition => DocumentDefinition.find_by_document_code("OASIS_OF")})
    elsif vt_docs[index] == "Discharge"
      vt.visit_type_document_definitions.create!({:mandatory_flag => false, :document_definition => DocumentDefinition.find_by_document_code("OASIS_TIFPND")})
      vt.visit_type_document_definitions.create!({:mandatory_flag => false, :document_definition => DocumentDefinition.find_by_document_code("OASIS_TIFPD")})
      vt.visit_type_document_definitions.create!({:mandatory_flag => false, :document_definition => DocumentDefinition.find_by_document_code("OASIS_DAH")})
      vt.visit_type_document_definitions.create!({:mandatory_flag => false, :document_definition => DocumentDefinition.find_by_document_code("OASIS_DFA")})
    end

    vt.state_transitions.build({:from_state => 'pending_evaluation', :to_state => 'active'}) if vt_docs[index] == "Evaluation"
    vt.state_transitions.build({:from_state => 'active', :to_state => 'active'}) if vt_docs[index] == "Evaluation" || vt_docs[index] == "Followup"
    vt.state_transitions.build({:from_state => 'any_state', :to_state => 'discharged'}) if vt_docs[index] == "Discharge"
    vt.save(:validate => false)
    license_visit_types[index].each do |lvt|

      LicenseTypesVisitType.create!(:visit_type_id => vt.id, :license_type_id => LicenseType.find_by_license_type_code(lvt).id )
    end
  end

  pt = VisitType.find_by_visit_type_code("PT_EVAL")
  sn = VisitType.find_by_visit_type_code("SN_EVAL")
  VisitTypeDocumentDefinition.create!({:mandatory_flag => false, :visit_type_id => pt.id,
                                      :document_definition => DocumentDefinition.find_by_document_name("Plan Of Care (485)")})
  VisitTypeDocumentDefinition.create!({:mandatory_flag => false, :visit_type_id => sn.id,
                                      :document_definition => DocumentDefinition.find_by_document_name("Plan Of Care (485)")})

  oasis = VisitType.new({:visit_type_code => "SOC_OASIS", :visit_type_description => "Start Of Care OASIS", :discipline_id => nil,
                         :payable_rate => "10", :org_id => org.id, :sort_order => 4})
  oasis.visit_type_document_definitions.build(:visit_type => oasis, :mandatory_flag => true, :document_definition => DocumentDefinition.find_by_document_name("OASIS Evaluation"))
  oasis.license_types << LicenseType.find_by_license_type_code('PT')
  oasis.license_types << LicenseType.find_by_license_type_code('SN')
  oasis.state_transitions.build({:from_state => 'pending_evaluation', :to_state => 'active'})
  oasis.save!

  soc = VisitType.new({:visit_type_code => "SOC", :visit_type_description => "Start Of Care", :discipline_id => nil,
                         :payable_rate => "10", :org_id => org.id, :sort_order => 4})
  soc.visit_type_document_definitions.build(:visit_type => soc, :mandatory_flag => true, :document_definition => DocumentDefinition.find_by_document_name("Plan Of Care (485)"))
  soc.license_types << LicenseType.find_by_license_type_code('PT')
  soc.license_types << LicenseType.find_by_license_type_code('SN')
  soc.state_transitions.build({:from_state => 'pending_evaluation', :to_state => 'active'})
  soc.save!


  #languages
  Language.destroy_all

  language_codes = ["AR", "FA", "EN", "IT", "SP", "AM", "FR", "JA", "TA", "C1", "C2", "GR", "RU", "VI", "KR", "TR"]
  language_descriptions = ["Arabic", "Farsi", "English", "Italian", "Spanish", "Armenian", "French", "Japanese", "Tagalog",
                           "Chinese Mandarin", "Chinese Cantonese", "German", "Russian", "Vietnamese", "Korean", "Turkish" ]

  language_codes.each_with_index do |code, index|
    Language.create!({:language_code => code, :language_description => language_descriptions[index]})
  end


  #Field Staff Creation
  FieldStaff.destroy_all


  Org.current = org
  fs1 = FieldStaff.new({:email => "fnpublic+roger@gmail.com", :password => "test1234",
                      :password_confirmation => "test1234", :first_name => "Roger", :last_name => "Federer", :suite_number => '7950',
                          :street_address => "West 3rd Street", :city => "Los Angeles", :state => "CA", :zip_code => '90048'})
  fs1.gender = 'M'
  fs1.sign_password = "test1234"
  fs1.sign_password_confirmation = "test1234"
  fs1.license_type = LicenseType.find_by_license_type_code("PT")
  fs1.license_number = "11111"
  fs1.languages << Language.find_by_language_code("EN")
  fs1.languages << Language.find_by_language_code("IT")
  fs1.languages << Language.find_by_language_code("C1")
  fs1.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Driver License").id,
                         :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/driving_license.pdf")})
  fs1.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Auto Insurance").id,
                         :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/auto_insurance.pdf")})
  fs1.save!

  fs2 = FieldStaff.new({:email => "fnpublic+steffi@gmail.com", :password => "test1234",
                            :password_confirmation => "test1234", :first_name => "Steffi", :last_name => "Graf", :suite_number => '1419',
                            :street_address => "Westwood Blvd", :city => "Los Angeles", :state => "CA", :zip_code => '90024'})
  fs2.gender = 'F'
  fs2.sign_password = "test1234"
  fs2.sign_password_confirmation = "test1234"
  fs2.license_type = LicenseType.find_by_license_type_code("PT")
  fs2.license_number = "22222"
  fs2.languages << Language.find_by_language_code("EN")
  fs2.languages << Language.find_by_language_code("IT")
  fs2.languages << Language.find_by_language_code("SP")
  fs2.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Driver License").id,
                         :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/driving_license.pdf")})
  fs2.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Auto Insurance").id,
                         :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/auto_insurance.pdf")})
  fs2.save!

  fs3 = FieldStaff.new({:email => "fnpublic+andy@gmail.com", :password => "test1234",
                             :password_confirmation => "test1234", :first_name => "Andy", :last_name => "Roddick", :suite_number => '641',
                             :street_address => "N Highland Ave", :city => "Los Angeles", :state => "CA", :zip_code => '90036'})
  fs3.gender = 'M'
  fs3.sign_password = "test1234"
  fs3.sign_password_confirmation = "test1234"
  fs3.license_type = LicenseType.find_by_license_type_code("OT")
  fs3.license_number = "33333"
  fs3.languages <<  Language.find_by_language_code("EN")
  fs3.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Driver License").id,
                         :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/driving_license.pdf")})
  fs3.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Auto Insurance").id,
                         :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/auto_insurance.pdf")})
  fs3.save!

  fs4 = FieldStaff.new({:email => "fnpublic+boris@gmail.com", :password => "test1234",
                             :password_confirmation => "test1234", :first_name => "Boris", :last_name => "Becker", :suite_number => '6602',
                             :street_address => "Melrose Ave", :city => "Los Angeles", :state => "CA", :zip_code => '90038'})
  fs4.gender = 'M'
  fs4.sign_password = "test1234"
  fs4.sign_password_confirmation = "test1234"
  fs4.license_type = LicenseType.find_by_license_type_code("PTA")
  fs4.license_number = "44444"
  fs4.languages <<  Language.find_by_language_code("EN")
  fs4.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Driver License").id,
                         :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/driving_license.pdf")})
  fs4.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Auto Insurance").id,
                         :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/auto_insurance.pdf")})
  fs4.save!

  fs5 = FieldStaff.new({:email => "fnpublic+monica@gmail.com", :password => "test1234",
                             :password_confirmation => "test1234", :first_name => "Monica", :last_name => "Seles", :suite_number => "7659",
                             :street_address => "Coney Island Ave.", :city => "Los Angeles", :state => "CA", :zip_code => '90023'})
  fs5.gender = 'F'
  fs5.sign_password = "test1234"
  fs5.sign_password_confirmation = "test1234"
  fs5.license_type = LicenseType.find_by_license_type_code("SN")
  fs5.license_number = "55555"
  fs5.languages <<  Language.find_by_language_code("EN")
  fs5.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Driver License").id,
                         :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/driving_license.pdf")})
  fs5.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Competency").id,
                         :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/auto_insurance.pdf")})
  fs5.save!

  fs6 = FieldStaff.new({:email => "fnpublic+martin@gmail.com", :password => "test1234",
                        :password_confirmation => "test1234", :first_name => "Martin", :last_name => "Billy", :suite_number => "5971",
                        :street_address => "West Wood Island Ave.", :city => "Los Angeles", :state => "CA", :zip_code => '90023'})
  fs6.gender = 'M'
  fs6.sign_password = "test1234"
  fs6.sign_password_confirmation = "test1234"
  fs6.license_type = LicenseType.find_by_license_type_code("SNA")
  fs6.license_number = "66666"
  fs6.languages <<  Language.find_by_language_code("EN")
  fs5.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Driver License").id,
                         :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/driving_license.pdf")})
  fs6.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Competency").id,
                         :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/auto_insurance.pdf")})
  fs6.save!




  fs7 = FieldStaff.new({:email => "fnpublic+pete@gmail.com", :password => "test1234",
                        :password_confirmation => "test1234", :first_name => "Pete", :last_name => "Sampras", :suite_number => "8329",
                        :street_address => "1656 Union Street", :city => "Los Angeles", :state => "CA", :zip_code => '90012'})
  fs7.gender = 'M'
  fs7.sign_password = "test1234"
  fs7.sign_password_confirmation = "test1234"
  fs7.license_type = LicenseType.find_by_license_type_code("ST")
  fs7.license_number = "77777"
  fs7.languages <<  Language.find_by_language_code("EN")
  fs7.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Driver License").id,
                         :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/driving_license.pdf")})
  fs7.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Auto Insurance").id,
                         :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/auto_insurance.pdf")})
  fs7.save!


  fs8 = FieldStaff.new({:email => "fnpublic+andre@gmail.com", :password => "test1234",
                        :password_confirmation => "test1234", :first_name => "Andre", :last_name => "Agassi", :suite_number => "8329",
                        :street_address => "6901 McKinley Avenue", :city => "Los Angeles", :state => "CA", :zip_code => '90012'})
  fs8.gender = 'M'
  fs8.sign_password = "test1234"
  fs8.sign_password_confirmation = "test1234"
  fs8.license_type = LicenseType.find_by_license_type_code("STA")
  fs8.license_number = "88888"
  fs8.languages <<  Language.find_by_language_code("EN")
  fs8.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Driver License").id,
                         :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/driving_license.pdf")})
  fs8.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Auto Insurance").id,
                         :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/auto_insurance.pdf")})
  fs8.save!


  fs9 = FieldStaff.new({:email => "fnpublic+latin@gmail.com", :password => "test1234",
                        :password_confirmation => "test1234", :first_name => "Latin", :last_name => "Hewitt", :suite_number => "7459",
                        :street_address => "1419 Westwood Blvd", :city => "Los Angeles", :state => "CA", :zip_code => '90024'})
  fs9.gender = 'M'
  fs9.sign_password = "test1234"
  fs9.sign_password_confirmation = "test1234"
  fs9.license_type = LicenseType.find_by_license_type_code("MSW")
  fs9.license_number = "99999"
  fs9.languages <<  Language.find_by_language_code("EN")
  fs9.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Driver License").id,
                         :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/driving_license.pdf")})
  fs9.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Auto Insurance").id,
                         :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/auto_insurance.pdf")})
  fs9.save!

  fs10 = FieldStaff.new({:email => "fnpublic+jimmy@gmail.com", :password => "test1234",
                        :password_confirmation => "test1234", :first_name => "Jimmy", :last_name => "Conors", :suite_number => "1178",
                        :street_address => "8032 W 3rd St", :city => "Los Angeles", :state => "CA", :zip_code => '90048'})
  fs10.gender = 'M'
  fs10.sign_password = "test1234"
  fs10.sign_password_confirmation = "test1234"
  fs10.license_type = LicenseType.find_by_license_type_code("CHHA")
  fs10.license_number = "91919"
  fs10.languages <<  Language.find_by_language_code("EN")
  fs10.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Driver License").id,
                         :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/driving_license.pdf")})
  fs10.credentials.build({:credential_type_id => FieldStaffCredentialType.find_by_ct_description("Auto Insurance").id,
                         :expiry_date => Date.today.next_year, :attachment => File.new("#{Rails.root}/db/samples/auto_insurance.pdf")})
  fs10.save!

#OrderType
  OrderType.destroy_all

  OrderType.create!(type_code: "EVAL", type_description: "Evaluation")
  OrderType.create!(type_code: "FREQ_CHANGES", type_description: "Frequency Changes")
  OrderType.create!(type_code: "MED_CHANGES", type_description: "Medication Changes")
  OrderType.create!(type_code: "OUT_OF_RG_VTS", type_description: "Out of Range Vitals")
  OrderType.create!(type_code: "LAPS_IN_EVAL", type_description: "Lapse in Evaluation")
  OrderType.create!(type_code: "MISSED_VISIT", type_description: "Missed Visit")
  OrderType.create!(type_code: "FREQ_NOT_ALLOW", type_description: "Frequency is Not Allowed")
  OrderType.create!(type_code: "HOLD_DISP", type_description: "Holding a Discipline/Patient")
  OrderType.create!(type_code: "UNHOLD_DISP", type_description: "Unholding a Discipline/Patient")
  OrderType.create!(type_code: "DISCHARGE_DISP", type_description: "Discharge a Discipline/Patient")
  OrderType.create!(type_code: "PLAN_OF_CARE", type_description: "Plan of Care-485")
  OrderType.create!(type_code: "OTHER", type_description: "Other")


# Medication

Medication.destroy_all

Medication.create!(drug_name: "Wi OM 100 DT", dosage: "0.5mg", active_ingredients:'Cefpodoxine 1', status: 'A', ndu_code: '102396')
Medication.create!(drug_name: "Winitro", dosage: "100 mg", active_ingredients:'CR Glyceryl Trinitrate', status: 'A', ndu_code: '102391')
Medication.create!(drug_name: "2 Dep ", dosage: "20 mg", active_ingredients:'Duloxetine', status: 'A', ndu_code: '102393')
Medication.create!(drug_name: "2B12 ", dosage: "20 mg", active_ingredients:'Folic Acid', status: 'A', ndu_code: '102392')

#Physician

Physician.destroy_all

 a = Physician.new(first_name: "Brendan", last_name: "Braun", suite_number: "234 ", street_address: "Manhut ", city: "NY", state: "NY ", zip_code: "52345", phone_number: "(888) 415-9370", npi_number: "1234x3", email: "fnpublic+brendan@gmail.com")
 a.npi_number = "123456"
 a.save!
b = Physician.new(first_name: "Tommie", last_name: "Becker", suite_number: "236 ", street_address: "Miller ", city: "WT", state: "WT ", zip_code: "51341", phone_number: "(831) 366-1234", npi_number: "1c34x3", email: "fnpublic+tommie@gmail.com")
b.npi_number = "123456"
b.save!
 #Physician.create!(first_name: "Kiley", last_name: "Welch", suite_number: "236 ", street_address: "BKM ", city: "CA", state: "CA", zip_code: "56234", phone_number: "(421) 415-8362", npi_number: "A23413", email: "physician2@gmail.com" )
 #Physician.create!(first_name: "Tommie", last_name: "Becker", suite_number: "2-12 ", street_address: "Miller", city: "NY", state: "NY ", zip_code: "52342", phone_number: "(423)-415-4270", npi_number: "12B463", email: "physician3@gmail.com" )
 #Physician.create!(first_name: "Westley", last_name: "Deckow", suite_number: "A-10 ", street_address: "Gale", city: "WT", state: "WT", zip_code: "51341", phone_number: "(831)-366-1234", npi_number: "1c34x3", email: "physician4@gmail.com" )
 #Physician.create!(first_name: "Davon", last_name: "Denesik", suite_number: "c-13 ", street_address: "Steeve", city: "NY", state: "CE", zip_code: "53340", phone_number: "(666)-312-4217", npi_number: "12349C", email: "physician5@gmail.com" )

#Insurance Company

InsuranceCompany.destroy_all
[facility_owner, org1, org2].each{|org|
  Org.current = org
  InsuranceCompany.create(company_name: "Medicare Health Insurance", company_code: "MEDICARE", certification_period: 60, co_pay_applicable: false, org_id: org.id)
  InsuranceCompany.create(company_name: "Metropolitan Life Insurance Company", company_code: "METLIFE", certification_period: 0, co_pay_applicable: true, org_id: org.id)
}

#Ethnicity
Ethnicity.destroy_all
  Ethnicity.create!(id: "1", description: "American Indian or Alaska Native")
  Ethnicity.create!(id: "2", description: "Asian")
  Ethnicity.create!(id: "3", description: "Black or African-American")
  Ethnicity.create!(id: "4", description: "Hispanic or Latino")
  Ethnicity.create!(id: "5", description: "Native Hawaiian or Pacific Islander")
  Ethnicity.create!(id: "6", description: "White")

#Payment Source
PaymentSource.destroy_all

  PaymentSource.create!(id: "0", description: "None; no charge for current services")
  PaymentSource.create!(id: "1", description: "Medicare (traditional fee-for-service)")
  PaymentSource.create!(id: "2", description: "Medicare (HMO/managed care/Advantage plan)")
  PaymentSource.create!(id: "3", description: "Medicaid (traditional fee-for-service)")
  PaymentSource.create!(id: "4", description: "Medicaid (HMO/managed care)")
  PaymentSource.create!(id: "5", description: "Worker`s compensation")
  PaymentSource.create!(id: "6", description: "Title programs (e.g., Title III, V, or XX)")
  PaymentSource.create!(id: "7", description: "Other government (e.g., TriCare, VA, etc.)")
  PaymentSource.create!(id: "8", description: "Private insurance")
  PaymentSource.create!(id: "9", description: "Private HMO/managed care")
  PaymentSource.create!(id: "10", description: "Self-pay")
  #PaymentSource.create!(id: "11", description: "Other (specify)")

#States

states = {:AL=>"Alabama", :AK=>"Alaska", :AZ=>"Arizona", :AR=>"Arkansas", 
          :CA=>"California", :CO=>"Colorado", :CT=>"Connecticut", :DE=>"Delaware",
          :FL=>"Florida", :GA=>"Georgia", :HI=>"Hawaii", :ID=>"Idaho",
          :IL=>"Illinois", :IN=>"Indiana", :IA=>"Iowa", :KS=>"Kansas",
          :KY=>"Kentucky", :LA=>"Louisiana", :ME=>"Maine", :MD=>"Maryland",
          :MA=>"Massachusetts", :MI=>"Michigan", :MN=>"Minnesota", :MS=>"Mississippi",
          :MO=>"Missouri", :MT=>"Montana", :NE=>"Nebraska", :NV=>"Nevada",
          :NH=>"New Hampshire", :NJ=>"New Jersey", :NM=>"New Mexico",
          :NY=>"New York", :NC=>"North Carolina", :ND=>"North Dakota",
          :OH=>"Ohio", :OK=>"Oklahoma", :OR=>"Oregon", :PA=>"Pennsylvania",
          :RI=>"Rhode Island", :SC=>"South Carolina", :SD=>"South Dakota",
          :TN=>"Tennessee", :TX=>"Texas", :UT=>"Utah", :VT=>"Vermont",
          :VA=>"Virginia", :WA=>"Washington", :WV=>"West Virginia",
          :WI=>"Wisconsin", :WY=>"Wyoming"}

State.destroy_all

states.each do |k, v|
  State.create!(state_code: "#{k}", state_description: "#{v}")
end

  Supply.delete_all
  require 'csv'

  file = File.join(Rails.root, 'static_data', 'supply', 'HHCB_db_7-1-2013.csv')

  CSV.foreach(file, { :headers => true }) do |row|
    [facility_owner, org1, org2].each{|org|
      Supply.create!( {
                          :supply_hcpcs_code => row[0],
                          :supply_description => row[1],
                          :org => org,
                      })
    }
  end

  # Discharge Forms V2

  doc_set = DocumentDefinitionSet.find_by_set_name("Default")
  template_set = DocumentFormTemplateSet.find_by_set_name("Default")
  if doc_set.present? and template_set.present?
    template_names = ["PTDischargeV2", "STDischargeV2", "OTDischargeV2", "SNDischargeV2", "MSWDischargeV2"]
    template_descriptions = ["PT Discharge V2", "ST Discharge V2", "OT Discharge V2", "SN Discharge V2", "MSW Discharge V2"]
    document_class_names = ["PTDischargeFormV2", "STDischargeFormV2", "OTDischargeFormV2", "SNDischargeFormV2", "MSWDischargeFormV2"]
    document_codes = ["PT_DISCHARGE", "ST_DISCHARGE", "OT_DISCHARGE", "SN_DISCHARGE", "MSW_DISCHARGE"]

    (0..4).each{|i|
      template = DocumentFormTemplate.create!(template_name: template_names[i], template_description: template_descriptions[i],
                                              document_class_name: document_class_names[i], status: "A", report_file_name: "generic_template")
      docs = DocumentDefinition.where(:document_code => document_codes[i])
      docs.update_all("document_form_template_id" => template.id)
      template_set.document_form_templates << template
      doc_set.document_definitions << docs
      template_set.save!
      doc_set.save!
    }
  end

end


if Rails.env == "test"
  #load "#{Rails.root}/load_zips.rb"

  Thread.current[:events] = {}
=begin
  facility_owner = FacilityOwner.create!({"org_name"=>"Fasternotes Facility", "org_package"=>"P", "week_start_day"=>"MON",
                                          "suite_number"=>"113", "street_address"=>"North Center Dr.", "city"=>"New York", "state"=>"NY",
                                          "zip_code"=>"11203", "email"=>"admin@fasternotes.com", "preferred_alert_mode"=>"E", "notes"=>"",
                                          "phone_number"=>"(212) 403-1212", "fax_number"=>"(212) 403-1213",
                                          :primary_contact_first_name => "William",
                                          :primary_contact_last_name => "Dawon", :primary_contact_phone_number => "(212) 403-1109",
                                          :primary_contact_email => "william@fasternotes.com.com", :primary_contact_password => "test1234",
                                          :primary_contact_password_confirmation => "test1234", :fed_tax_number => "123456799"}, {:without_protection => true})

  users = ['sa1', 'sa2']
  first_names = ["Emma", "Tina",]
  last_names = ["Will", "Miller"]
  users.each_with_index do |role, i|
    user = SuperAdmin.create!(first_name: first_names[i], last_name: last_names[i], email: "#{role}@fasternotes.com", password: "test1234", password_confirmation: "test1234")
    facility_owner.users << user
  end

  User.current = User.find_by_email "sa1@fasternotes.com"
  ctype = ContactType.create(type_name: "Authorized Representative")

  debug_log "Creating HA........."
  #email = is_production ? "ihhpie@gmail.com" : get_email("Ybardolaza")
  agency_num = "100"
  health_agency = HealthAgency.new
  health_agency.org_name = "Test Home Health Providers, INC"
  health_agency.org_type = "HealthAgency"
  health_agency.org_package = 'P'
  health_agency.week_start_day = 'SUN'
  health_agency.suite_number = "1231"
  health_agency.street_address = "9221 Archibald Ave"
  health_agency.city = "Rancho Cucamonga"
  health_agency.state = 'CA'
  health_agency.zip_code = "91730"
  health_agency.preferred_alert_mode = 'E'
  health_agency.email = "fnpublic+john@gmail.com"
  health_agency.phone_number = "(909) 948-8731"
  health_agency.fax_number = "(909) 948-8736"
  health_agency.fed_tax_number = "123456789"
  #health_agency.npi_number = "123456789"
  health_agency.primary_contact_first_name = "test"
  health_agency.primary_contact_last_name = "Ybardolaza"
  health_agency.primary_contact_email = "fnpublic+johne@gmail.com"
  health_agency.primary_contact_phone_number = "(345) 123-45678"
  health_agency.primary_contact_password = "password"
  health_agency.primary_contact_password_confirmation = "password"
  health_agency.save!

  debug_log "Creating HA Detail........."
  health_agency_detail = health_agency.health_agency_detail || HealthAgencyDetail.new
  health_agency_detail.provider_number = "HH240001913"
  health_agency_detail.cms_cert_number = "058239"
  health_agency_detail.npi_number = "1093854176"
  health_agency_detail.submitter_id = "A08123123"
  health_agency_detail.health_agency_id = health_agency.id
  health_agency_detail.document_definition_set = DocumentDefinitionSet.find_by_set_name("HHA")
  health_agency_detail.document_form_template_set = DocumentFormTemplateSet.find_by_set_name("HHA")
  health_agency_detail.save!

  Discipline.create!(discipline_code: "PT", discipline_description: "Physical Therapy", sort_order: 2)
  Discipline.create!(discipline_code: "OT", discipline_description: "Occupational Therapy", sort_order: 3)
  Discipline.create!(discipline_code: "ST", discipline_description: "Speech Therapy", sort_order: 4)
  Discipline.create!(discipline_code: "SN", discipline_description: "Skilled Nursing", sort_order: 1)
  Discipline.create!(discipline_code: "MSW", discipline_description: "Social Worker", sort_order: 5)
  Discipline.create!(discipline_code: "CHHA", discipline_description: "Certified Home Health Agency", sort_order: 6)

  LicenseType.destroy_all

  LicenseType.create!(license_type_code: "PT", license_type_description: "Physical Therapist",
                      discipline_id: Discipline.find_by_discipline_code("PT").id, independent_flag: true)
  LicenseType.create!(license_type_code: "PTA", license_type_description: "Physical Therapist Assistant",
                      discipline_id: Discipline.find_by_discipline_code("PT").id, independent_flag: false)
  LicenseType.create!(license_type_code: "OT", license_type_description: "Occupational Therapist",
                      discipline_id: Discipline.find_by_discipline_code("OT").id, independent_flag: true)
  LicenseType.create!(license_type_code: "OTA", license_type_description: "Occupational Therapist Assistant",
                      discipline_id: Discipline.find_by_discipline_code("OT").id, independent_flag: false)
  LicenseType.create!(license_type_code: "ST", license_type_description: "Speech Therapist",
                      discipline_id: Discipline.find_by_discipline_code("ST").id, independent_flag: true)
  LicenseType.create!(license_type_code: "STA", license_type_description: "Speech Therapist Assistant",
                      discipline_id: Discipline.find_by_discipline_code("ST").id, independent_flag: false)
  LicenseType.create!(license_type_code: "SN", license_type_description: "Skilled Nurse",
                      discipline_id: Discipline.find_by_discipline_code("SN").id, independent_flag: true)
  LicenseType.create!(license_type_code: "SNA", license_type_description: "Skilled Nurse Assistant",
                      discipline_id: Discipline.find_by_discipline_code("SN").id, independent_flag: false)
  LicenseType.create!(license_type_code: "MSW", license_type_description: "Social Worker",
                      discipline_id: Discipline.find_by_discipline_code("MSW").id, independent_flag: true)
  LicenseType.create!(license_type_code: "CHHA", license_type_description: "Care Planer",
                      discipline_id: Discipline.find_by_discipline_code("CHHA").id, independent_flag: true)

  zip_code = ZipCode.create(locality: "Los Angeles", zip_code: "90012", admin_name_1: "California", admin_code_1: "CA",
  admin_name_2: "Los Angeles", admin_code_2: "037", lat: 34.061400, lng: -118.238500)

  User.current = User.find_by_email("fnpublic+johne@gmail.com")

  os = OrgStaff.new
  os.role_type = "A"
  os.first_name = "John"
  os.last_name = "Meccalain"
  os.email = "fnpublic+john3@gmail.com"
  os.password = "test1234"
  os.password_confirmation = "test1234"
  os.user_status =
  os.org_id = health_agency.id
  os.save!

  visit_type = VisitType.new
  visit_type.visit_type_code = "PT_EVAL"
  visit_type.visit_type_description = "PT Evaluation"
  visit_type.payable_rate = 20.0
  visit_type.discipline = Discipline.find_by_discipline_code("PT")
  visit_type.sort_order = 1
  license_type_codes = ["PT", "PTA"]
  license_type_codes.each do |license_type_code|
    visit_type.license_types << LicenseType.find_by_license_type_code(license_type_code)
  end
  visit_type.save!

  doc_set = DocumentDefinitionSet.create!(set_name: "Default", set_description: "Default Documents Set")
  tpl_set = DocumentFormTemplateSet.create!(set_name: "Default", set_description: "Default Form Templates Set")

  template_names = ["PTEvaluation", "PTFollowup", "PTDischarge"]
  template_descriptions = ["PT Evaluation", "PT Followup", "PT Discharge"]
  document_class_names = ["PTEvaluationForm", "PTFollowUpForm", "PTDischargeForm"]
  document_codes = ["PT_EVAL", "PT_FOLLOWUP", "PT_DISCHARGE"]
  document_names = ["PT Evaluation", "PT Followup", "PT Discharge"]
  template_names.each_with_index do |name, index|
    tpl = DocumentFormTemplate.create!(template_name: template_names[index], template_description: template_descriptions[index],
                                       document_class_name: document_class_names[index], status: "A", report_file_name: "generic_template")
    doc = DocumentDefinition.create!(document_code: document_codes[index], document_name: document_names[index], document_form_template_id: tpl.id,
                                     org_id: Org.current.id, payable_rate: 20)
    tpl_set.document_form_templates << tpl
    doc_set.document_definitions << doc
  end

  doc_def_codes = ["PT_EVAL", "PT_FOLLOWUP", "PT_DISCHARGE"]
  doc_def_codes.each do |doc_def_code|
    visit_type_doc_def = visit_type.visit_type_document_definitions.build
    visit_type_doc_def.document_definition = DocumentDefinition.find_by_document_code(doc_def_code)
    visit_type_doc_def.save!
  end

  states_map = {"PE" => :pending_evaluation, "AC" => :active, "HD" => :on_hold, "DC" => :discharged, "AS" => :any_state}
  transitions = {"PE-AC" => 'X', "PE-DC" => 'X', "AC-DC" => nil, "HD-AC" => nil,
                 "HD-DC" => nil, "AS-AS" => 'X'}

  transitions.each do |states, value|
    next unless ['x', 'X'].include?(value)
    next if states.blank?
    visit_type_state_transition = visit_type.state_transitions.build

    from_state, to_state = states.split('-')
    visit_type_state_transition.from_state = states_map[from_state]
    visit_type_state_transition.to_state = states_map[to_state]
    visit_type_state_transition.save!
  end

  order_type = OrderType.create(type_code: "REHAB_EVAL", type_description: "REHAB EVALUATION", system_required: false)
  health_agency.order_types << order_type

  attachment_type = AttachmentType.create(attachment_code: "MEDICAL_ORDER", attachment_description: "Medical Order",
                                          system_required: true, org_id: health_agency.id)
  attachment_type.save!

  ins = InsuranceCompany.new(company_name: "Medicare Insurance", company_code: "MEDICARE", claim_street_address: "Wal Disney St",
                             claim_suite_number: 345, claim_zip_code: 90012, claim_city: "NewYork", certification_period: 60,
                             claim_state: "LA", claim_phone_number: "(123) 3456-789")
  ins.save!

  physician = Physician.new
  physician.first_name = "Mathew"
  physician.last_name = "Headen"
  physician.suffix = "Dr"
  physician.street_address = "Wall Street"
  physician.suite_number = "123"
  physician.zip_code = "90012"
  physician.npi_number = "1234567890"
  physician.phone_number = "(123) 4567-890"
  physician.fax_number = "(123) 4567-890"
  physician.email = "fnpublic+physician@gmail.com"
  physician.personal_phone_number_1 = "(345) 7890-123"
  physician.personal_phone_number_2 = "(345) 7890-124"
  physician.save!


  #['SN', 'PT'].each do |f|
    field_staff = FieldStaff.new
    field_staff.first_name = "Steve"
    field_staff.last_name = "Mark"
    field_staff.street_address = "New warner st."
    field_staff.suite_number = "556"
    field_staff.zip_code = "90012"
    zip_code = ZipCode.find_by_zip_code("90012")
    field_staff.city = "New York"
    field_staff.state = "LA"
    field_staff.email = "fnpublic+steve@gmail.com"
    field_staff.phone_number = "(456) 7890-123"
    field_staff.phone_number_2 = "(456) 7890-124"
    field_staff.fax_number = "(456) 7890-123"
    field_staff.gender = "M"
    field_staff.license_number = "4567890123"
    field_staff.license_type = LicenseType.find_by_license_type_code("SN")
    languages = []
    languages.each do |lang|
      language = Language.find_by_language_description(lang.strip)
      field_staff.languages << language unless language.nil?
    end
    field_staff.password = "test1234"
    field_staff.password_confirmation = "test1234"
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
      org_fs_visit_type.payable_rate = fs_vt_row[3].gsub('$', '').strip.to_f
      org_fs_visit_type.save!
    end
end

  #User.current = User.find_by_email "fnpublic+john@gmail.com"

  patient = Patient.new
  patient.draft_status = true
  patient.set_random_email
  patient.set_random_password
  patient.save(:validate => false)

  patient.first_name = "Praveen26"
  patient.last_name = "K"
  patient.dob = (Date.current - 10000)
  patient.gender = 'M'
  patient.ssn = '981276345'
  patient.medicare_number = '981276345M'
  patient.street_address = 'Same Street'
  patient.zip_code = '90012'
  patient.city = 'Los Angeles'
  patient.state = 'CA'
  patient.phone_number = '(310) 752-1234'
  patient.patient_insurance_companies.create!({insurance_company_id: InsuranceCompany.find_by_company_code("MEDICARE").id,
                                     patient_insurance_number: "981276345M", effective_date: (Date.current - 350)})
  patient.save!

  referral = TreatmentRequest.new
  referral.patient = patient
  referral.request_date = (Date.current - 300)
  referral.referred_physician = Physician.first
  referral.insurance_company = InsuranceCompany.find_by_company_code("MEDICARE")
  sn = Discipline.find_by_discipline_code("SN")
  pt = Discipline.find_by_discipline_code("PT")

  referral.discipline_ids = [sn.id, pt.id]
  referral.referral_received_date = (Date.current - 300)
  referral.point_of_origin = '1'
  referral.save!

  referral.system_driven_event = true
  referral.eligibility_check_complete! if referral.may_eligibility_check_complete?
  referral.referral_received! if referral.may_referral_received?
  referral.request_staffs.each{|rs|
    rs.staff = if rs.discipline_id == sn.id
                 FieldStaff.find_by_license_type(sn.disciplines.first)
               else
                 StaffingCompany.find(205)
               end
    rs.save!
  }
  referral.finalize_staffing! if referral.may_finalize_staffing?

  referral.update_column(:request_status, 'P')
  referral.soc_date = (Date.current - 300)

  referral.admit! if referral.may_admit?
  referral.system_driven_event = false

  treatment = referral.patient_treatment
  episode = treatment.treatment_episodes.first


  doc = OasisEvaluation.new
  doc.document_definition_id = 920
  doc.document_form_template_id = 112
  doc.document_date = Date.current
  doc.treatment_id = treatment.id
  doc.treatment_episode_id = treatment.treatment_episodes.first.id
  doc.physician_id = treatment.treatment_physicians.first.physician_id
  hash_values = YAML.load(File.read("#{Rails.root}/db/samples/oasis_soc_data.yml"))
  doc.data = hash_values.merge({"treatment_episode_id" => treatment.treatment_episodes.first.id, "field_staff_id" => 1699})
  doc.save!

  doc.sign! if doc.may_sign?
=end
end