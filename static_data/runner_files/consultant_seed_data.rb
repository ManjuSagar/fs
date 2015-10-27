class ConsultingSeedData
  def create_data
    consulting_company = ConsultingCompany.find_by_org_name("HHA Consulting Company, Inc.")
    unless consulting_company
      consulting_company = ConsultingCompany.new
      consulting_company.org_name = "HHA Consulting Company, Inc."
      consulting_company.org_package = "F"
      consulting_company.week_start_day = 'MON'
      consulting_company.suite_number = "123"
      consulting_company.street_address = "123 Main St."
      consulting_company.city = "Los Angeles"
      consulting_company.state = "CA"
      consulting_company.zip_code = "90025"
      consulting_company.email = "hhacci@gmail.com"
      consulting_company.preferred_alert_mode = 'E'
      consulting_company.phone_number = "(310) 752-1234"
      consulting_company.fax_number = "(310) 752-1234"
      consulting_company.fed_tax_number = "351593574"
      consulting_company.save(:validate => false)
    end

    consultant = Consultant.first
    unless consultant
      consultant = Consultant.new
      consultant.first_name = "Joe"
      consultant.last_name = "Baker"
      consultant.email = "hhacci@gmail.com"
      consultant.password = "test1234"
      consultant.password_confirmation = "test1234"
      consultant.suite_number = "123"
      consultant.street_address = "123 Main St."
      consultant.city = "Los Angeles"
      consultant.state = "CA"
      consultant.zip_code = "90025"
      consultant.phone_number = "(310) 752-1234"
      consultant.approved = true
      consultant.gender = 'M'
      consultant.save!
    end

    if consulting_company.users.size == 0
      org_user = OrgUser.new
      org_user.org_id = consulting_company.id
      org_user.user_id = consultant.id
      org_user.role_type = 'A'
      org_user.user_status = 'A'
      org_user.save!
    end

    current_client_names = ["ABC Home Health Care, Inc.", "Best Home Health Agency, Inc.", "Metropolitan Healthcare, Inc."]
    link_health_agencies(consulting_company, current_client_names, true)

    pending_client_names = ["Bonum Home Health Services"]
    link_health_agencies(consulting_company, pending_client_names)
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

ConsultingSeedData.new.create_data
