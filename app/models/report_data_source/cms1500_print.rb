module ReportDataSource
  class Cms1500Print

    include ReportRelatedBasicMethods

    attr_accessor :invoice, :invoice_details

    MAX_NO_OF_SERVICES = 6

    def initialize(invoice)
      @invoice = invoice
      @invoice_details = generate_private_insurance
    end

    def patient
      invoice.treatment.patient
    end

    def patient_dob_month
      patient.dob.strftime("%m")
    end

    def patient_dob_day
      patient.dob.strftime("%d")
    end

    def patient_dob_year
      patient.dob.strftime("%Y")
    end

    def gender
      patient.gender
    end

    def patient_full_name
      res = "#{patient.last_name}, #{patient.first_name}"
      patient.middle_initials.present? ? "#{res}, #{patient.middle_initials}" : res
    end

    def patient_address
      patient.address_line_1 if patient.present?
    end

    def patient_city
      patient.city if patient.present?
    end

    def patient_state
      patient.state
    end

    def patient_zip_code
      patient.zip_code
    end

    def patient_tele_phone
      tele_phone = patient.atleast_one_phone_number
      area_code, phone_number = tele_phone.split(')')
      [area_code[1..3], phone_number]
    end

    def insured_full_name
      patient_full_name if insured_person
    end

    def type_of_insurance
      invoice.treatment_episode.medicare? ? "Medicare" : "Other"
    end

    def insured_person
      patient_relationship_to_insured == "Self" ? patient : nil
    end

    def other_insured_person
      other_insurance.relation_to_insured_display == "Self" ? patient : nil
    end

    def patient_relationship_to_insured
      relation_ship = invoice.treatment.treatment_request.patient_relation_ship
      (['Self', 'Spouse', 'Child'].include? relation_ship) ? relation_ship : "Other"
    end

    def insured_address
      patient_address if insured_person
    end

    def insured_city
      patient_city if insured_person
    end

    def insured_state
      patient_state if insured_person
    end

    def insured_zipcode
      patient_zip_code if insured_person
    end

    def insured_dob_month
      patient.dob.strftime("%m") if insured_person
    end

    def insured_dob_day
      patient.dob.strftime("%d") if insured_person
    end

    def insured_dob_year
      patient.dob.strftime("%Y") if insured_person
    end

    def insured_gender
      patient.gender if insured_person
    end

    def insured_area_code
      patient_tele_phone[0] if insured_person
    end

    def insured_telephone
      patient_tele_phone[1] if insured_person
    end

    def other_insurance
      patient_insurances = patient.patient_insurance_companies
      if patient_insurances.size > 1
        patient_insurances[1]
      else
        nil
      end
    end

    def is_there_another_health_benifit_plan
      other_insurance.present? ? "Yes" : "No"
    end

    def other_insured_name
      patient_full_name if is_there_another_health_benifit_plan == "Yes" and other_insured_person
    end

    def other_insured_policy_or_group_number
       other_insurance.patient_insurance_number if other_insurance.present?
    end

    def insurance_plan_name
      other_insurance.to_s if other_insurance.present?
    end

    def employment?
      "NO"
    end

    def auto_accident?
      "NO"
    end

    def other_accident?
      "No"
    end

    def auto_accident_place
      nil
    end

    def claim_codes
      nil
    end

    def insured_policy_group_number
      nil
    end

    def insurance_company
      invoice.treatment.treatment_request.insurance_company
    end

    def treatment_request
      invoice.treatment.treatment_request
    end

    def physician
      treatment_request.referred_physician
    end

    def referring_provider_name
      physician.full_name
    end

    def name_of_referring_provider_applicable_qualifier
      "DN"
    end

    def npi_number_of_referring_provider
      physician.npi_number
    end

    def resubmission_code
      nil
    end

    def patient_fed_tax_number
      patient.ssn
    end

    def patient_account_number
      patient.patient_reference
    end

    def service_facility_location_name
      invoice.agency_name
    end

    def service_facility_location_building_name
      invoice.org.building_name
    end

    def service_facility_location_address
      invoice.agency_suite_number_street_address
    end

    def service_facility_location_city_state_zip
      invoice.agency_city_state_zip
    end

    def service_facility_location_npi_number
      invoice.agency_npi
    end

    def services
      list = []
      receivables = invoice.receivables - [invoice.home_health_service]
      original_services_count = receivables.size
      blank_receivables = original_services_count % MAX_NO_OF_SERVICES
      receivable = if invoice.class.to_s == "PrivateInsuranceInvoice"
                     PrivateReceivable.new(:receivable_date => "", :private_insurance_invoice => invoice)
                   else
                     Receivable.new(:receivable_date => "", :invoice => invoice)
                   end

      (MAX_NO_OF_SERVICES - blank_receivables).times{|i| receivables << receivable } unless (blank_receivables == 0 and invoice.invoice_type !='322')
      receivables.each do |rec|
        month = day = year = dollar = cents = service_units = service_response = family_plan = place_of_service =  nil
        if rec.receivable_date
          month = rec.receivable_date.strftime("%m")
          day = rec.receivable_date.strftime("%d")
          year = rec.receivable_date.strftime("%y")
          dollar, cents = rec.receivable_amount.to_s.split(".")
          cents = (cents || "00").ljust(2, '0')
          service_units = 1
          service_response = 'N'
          family_plan = 'N'
          place_of_service = "12"
        end
        list << {supplemental_information: nil, from_date_month_of_service: month, from_date_day_of_service: day,
                 from_date_year_of_service: year, to_date_month_of_service: month, to_date_day_of_service: day,
                 to_date_year_of_service: year, place_of_service: place_of_service, emergency: nil, hcpcs_code: rec.hcpcs_code, modifier1: rec.revenue_code,
                 diagnosis_pointer: nil, service_charge_before_decimal: dollar, service_charge_after_decimal: cents,
                 service_units: service_units, service_response: service_response, family_plan: family_plan, non_npi_identifier: nil,
                 service_non_npi_number: nil, rendering_provider_id: nil
        }
      end
      list
    end



    def generate_private_insurance
      data = {}
      data[:payer_name] = invoice.payer_full_name
      data[:payer_address1] = invoice.payer_address1
      data[:payer_address2] = invoice.payer_address2
      data[:payer_city_state_zipcode] = invoice.payer_city_details
      data[:type_of_health_insuarance] = type_of_insurance
      data[:insured_id_number] = invoice.medicare_number
      data[:patient_name] = patient_full_name
      data[:patient_dob_month] = patient_dob_month
      data[:patient_dob_day] = patient_dob_day
      data[:patient_dob_year] = patient_dob_year
      data[:patient_sex] = gender
      data[:insured_name] = insured_full_name
      data[:patient_address] = patient_address
      data[:patient_city] = patient_city
      data[:patient_state] = patient_state
      data[:patient_zipcode] = patient_zip_code
      data[:patient_telephone_area_code] = patient_tele_phone[0]
      data[:patient_telephone] = patient_tele_phone[1]
      data[:patient_relationship_to_insured] = patient_relationship_to_insured
      data[:insured_address] = insured_address
      data[:insured_city] = insured_city
      data[:insured_state] = insured_state
      data[:insured_zipcode] = insured_zipcode
      data[:insured_telephone_area_code] = insured_area_code
      data[:insured_telephone] = insured_telephone
      data[:other_insured_name] = other_insured_name
      data[:other_insured_policy_or_group_number] = other_insured_policy_or_group_number
      data[:insurance_plan_name] = insurance_plan_name
      data[:employment] = employment?
      data[:auto_accident] = auto_accident?
      data[:place] = auto_accident_place
      data[:other_accident] = other_accident?
      data[:claim_codes] = claim_codes
      data[:insured_policy_group_number] = insured_policy_group_number
      data[:insured_dob_month] = insured_dob_month
      data[:insured_dob_day] = insured_dob_day
      data[:insured_dob_year] = insured_dob_year
      data[:insured_sex] = insured_gender
      data[:other_claim_id_qualifier] = nil
      data[:other_claim_id] = nil
      data[:other_insurance_plan_name] = insurance_company.to_s
      data[:is_there_another_health_benefit_plan] = is_there_another_health_benifit_plan
      data[:patient_signature] = "SOF"
      data[:patient_sign_date] = Date.current.strftime("%m/%d/%Y")
      data[:insured_signature] = "SOF"
      data[:date_of_current_illness_month] = nil
      data[:date_of_current_illness_day] = nil
      data[:date_of_current_illness_year] = nil
      data[:date_of_current_illness_applicable_qualifier] = nil
      data[:other_date_month] = nil
      data[:other_date_day] = nil
      data[:other_date_year] = nil
      data[:other_date_applicable_qualifier] = nil
      data[:patient_unable_to_work_from_date_month] = nil
      data[:patient_unable_to_work_from_date_day] = nil
      data[:patient_unable_to_work_from_date_year] = nil
      data[:patient_unable_to_work_to_date_month] = nil
      data[:patient_unable_to_work_to_date_day] = nil
      data[:patient_unable_to_work_to_date_year] = nil
      data[:name_of_referring_provider] = referring_provider_name
      data[:name_of_referring_provider_applicable_qualifier] = name_of_referring_provider_applicable_qualifier
      data[:referring_provider_other_id] = nil
      data[:non_npi_referring_provider_qualifier] = nil
      data[:npi_number_of_referring_provider] = npi_number_of_referring_provider
      data[:hospitalization_from_date_month] = nil
      data[:hospitalization_from_date_day] = nil
      data[:hospitalization_from_date_year] = nil
      data[:hospitalization_to_date_month] = nil
      data[:hospitalization_to_date_year] = nil
      data[:hospitalization_to_date_day] = nil
      data[:additional_claim_information] = nil
      data[:is_outside_lab] = nil
      data[:charges] = nil
      data[:icd_code_version] = invoice.diagnosis_and_procedure_qualifier
      data[:icd_a] = invoice.icd_9_1
      data[:icd_b] = invoice.icd_9_2
      data[:icd_c] = invoice.icd_9_3
      data[:icd_d] = invoice.icd_9_4
      data[:icd_e] = invoice.icd_9_5
      data[:icd_f] = invoice.icd_9_6
      data[:icd_g] = invoice.icd_9_7
      data[:icd_h] = invoice.icd_9_8
      data[:icd_i] = invoice.icd_9_9
      data[:icd_j] = invoice.icd_9_10
      data[:icd_k] = invoice.icd_9_11
      data[:icd_l] = invoice.icd_9_12
      data[:resubmission_code] = resubmission_code
      data[:original_reference_number] = nil
      data[:prior_authorization_number] = nil
      data[:services] = services
      data[:federal_tax_id] = patient_fed_tax_number
      data[:federal_tax_id_type] = "SSN"
      data[:patient_account_number] = patient_account_number
      data[:accept_assignment] = nil
      data[:total_charge_before_decimal] = invoice.total_charge[0]
      data[:total_charge_after_decimal] = invoice.total_charge[1]
      data[:amount_paid] = nil
      data[:physician_signature] = "SOF"
      data[:physician_sign_date] = Date.current.strftime("%m/%d%Y")
      data[:service_facility_location_name] = service_facility_location_name
      data[:service_facility_location_address] = service_facility_location_address
      data[:service_facility_location_city_state_zipcode] = service_facility_location_city_state_zip
      data[:service_facility_location_npi_number] = invoice.agency_npi
      data[:service_facility_non_npi_number] = nil
      data[:billing_provider_name] = service_facility_location_name
      data[:billing_provider_address] = service_facility_location_address
      data[:billing_provider_city_state_zipcode] = service_facility_location_city_state_zip
      data[:billing_provider_npi_number] = invoice.agency_npi
      data[:billing_provider_non_npi_number] = nil
      data[:service_facility_location_building_name] = service_facility_location_building_name
      data[:billing_provider_building_name] = service_facility_location_building_name
      data
    end

    def jasper_report_url
      "#{Rails.root}/app/views/reports/cms_1500/cms_1500.jasper"
    end

    def xml_root
      "cms1500"
    end

    def pdf_options
      {methods: @invoice_details}
    end

  end
end
