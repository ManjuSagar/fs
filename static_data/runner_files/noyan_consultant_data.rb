class NoyanConsultantData
  def create_data
    #consulting_company = ConsultingCompany.find_by_org_name("HHA Consulting Company, Inc.")
    consulting_company = ConsultingCompany.find_by_org_name("Northeast Billing Group")
    unless consulting_company
      consulting_company = ConsultingCompany.new
      consulting_company.org_name = "Northeast Billing Group"
      consulting_company.org_package = "F"
      consulting_company.week_start_day = 'MON'
      consulting_company.suite_number = ""
      consulting_company.street_address = "803 N. Roanne Street"
      consulting_company.city = "Anaheim"
      consulting_company.state = "CA"
      consulting_company.zip_code = "92801"
      consulting_company.email = "alneb88@yahoo.com"
      consulting_company.preferred_alert_mode = 'E'
      consulting_company.phone_number = "(714) 983-8351"
      consulting_company.fax_number = "(714) 952-8688"
      consulting_company.fed_tax_number = "351593574"
      consulting_company.save(:validate => false)
    end

    #consultant = Consultant.first
    #unless consultant
    consultant = Consultant.new
    consultant.first_name = "Kaye"
    consultant.last_name = "Alabado"
    consultant.email = "alneb88@yahoo.com"
    consultant.password = "test1234"
    consultant.password_confirmation = "test1234"
    consultant.suite_number = ""
    consultant.street_address = "803 N. Roanne Street"
    consultant.city = "Anaheim"
    consultant.state = "CA"
    consultant.zip_code = "92801"
    consultant.phone_number = "(714) 983-8351"
    consultant.approved = true
    consultant.gender = 'M'
    consultant.save!
    #end

    if consulting_company.users.size == 0
      org_user = OrgUser.new
      org_user.org_id = consulting_company.id
      org_user.user_id = consultant.id
      org_user.role_type = 'A'
      org_user.user_status = 'A'
      org_user.save!
    end

    current_client_names = ["Noyan Home Health Care, Inc."]
    link_health_agencies(consulting_company, current_client_names, true)

  end

  def link_health_agencies(consulting_company, agencies, active = false)
    agencies.each{|name|
      hha = HealthAgency.where(["org_name = ?", name]).last
      ha = consulting_company.consulting_company_health_agencies.find_by_health_agency_id(hha.id)
      consulting_company.consulting_company_health_agencies.build(health_agency: hha, active: active) unless ha
    }
    consulting_company.save!
  end
end

NoyanConsultantData.new.create_data
