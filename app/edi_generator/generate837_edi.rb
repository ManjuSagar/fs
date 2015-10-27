
class Generate837Edi

  attr_accessor :claims, :org, :mode, :errors, :num_of_transaction_sets, :private_receivables

  def initialize(claims, mode, private_receivables = nil)
    @claims = claims
    @org = claims.first.org
    @mode = mode
    @errors = []
    @private_receivables = private_receivables
    @num_of_transaction_sets = 0
  end

  def fed_tax_number
    org.fed_tax_number
  end

  def submitter_id
    claim = claims.first
    claim.is_a?(PrivateInsuranceInvoice) ? 'MS55555' : org.health_agency_detail.submitter_id
  end

  def receiver_id
    claim = claims.first
    claim.is_a?(PrivateInsuranceInvoice) ? claim.payer.payer_id :  MedicareAdministrativeContractor.new(org, mode).receiver_id
  end

  def receiver_name
    claim = claims.first
    claim.payer.company_name
  end

  def submission_date
    Date.current.strftime('%y%m%d')
  end

  def submission_time
    Time.current.strftime('%H%M')
  end

  def submission_date_century
    Date.current.strftime('%Y%m%d')
  end

  def submitter_name
    org.org_name
  end

  def submitter_contact_name
    submitter_contact_person.full_name
  end

  def submitter_contact_person
    org.contacts.first
  end

  def submitter_contact_email
    org.email
  end

  def submitter_contact_phone_number
    org.phone_number.delete(' ()-')
  end

  def submitter_contact_fax_number
    org.fax_number.delete(' ()-')
  end

  def provider_taxonomy_code
    "251E00000X"
  end

  def billing_provider_address1
    org.street_address
  end

  def billing_provider_city
    org.city
  end

  def billing_provider_state
    org.state
  end

  def billing_provider_zip_code
    org.zip_code + org.zip_code_part2 if org.zip_code_part2
  end

  def individual_relationship_code(claim)
    claim.patient_relationship
  end

  def code_identifying_type_of_claim(claim)
    "MA"
  end

  def subscriber_last_name(claim)
    claim.patient_last_name
  end

  def subscriber_first_name(claim)
    claim.patient_first_name
  end

  def subscriber_identifier(claim)
    claim.patient_hi_claim_number
  end

  def subscriber(claim)
    claim.patient
  end

  def subscriber_suite_number(claim)
    "SUITE #{subscriber(claim).suite_number}" if subscriber(claim).suite_number.present?
  end

  def subscriber_ssn(claim)
    claim.patient.ssn.gsub('-','')
  end

  def claim_id(claim)
    claim.patient_control_number
  end

  def payer_address1(claim)
    if claim.payer.claim_street_address.present?
      claim.payer.claim_street_address[0..53]
    end
  end

  def payer_city(claim)
    if claim.payer.claim_city
      claim.payer.claim_city
    end
  end

  def payer_state(claim)
    if claim.payer.claim_state
      claim.payer.claim_state
    end
  end

  def statement_covers_period(claim)
    "#{claim.treatment_episode.start_date.strftime("%Y%m%d")}-#{claim.get_through_date.strftime("%Y%m%d")}"
  end

  def payer_zip_code(claim)
    if claim.payer.claim_zip_code
      claim.payer.claim_zip_code
    end
  end

  def admission_date(claim)
    claim.treatment.treatment_start_date.strftime("%Y%m%d") + "0000"
  end

  def icd_code(b, code, type_code)
    code.present? ? b.composite(type_code, code) : nil
  end

  def value_code(b, claim, index)
    hash = claim.value_codes_list[index]
    hash.present? ? b.composite('BE', hash.keys.first, nil, nil, hash.values.first ) : nil
  end

  def agency_npi_number
    org.health_agency_detail.npi_number
  end

  def get_file_name(file_type)
    ref = "#{Time.now.to_f}-#{rand(1000000)}".gsub('.','-') + "#{file_type}"
    name_prefix = submitter_name[0..2]
    name_suffix = "claims_#{ref}"
    (mode == 'T') ? "#{name_prefix}_test_#{name_suffix}" : "#{name_prefix}_#{name_suffix}"
  end

  def invoice_type(claim)
    if claim.final_claim?
      "9"
    elsif claim.lupa?
      "7"
    else
      "2"
    end
  end

  def submitter_contact_information(b)
    b.PER "IC", submitter_contact_name, "EM", submitter_contact_email, (submitter_contact_phone_number.blank? ? nil : "TE"),
          (submitter_contact_phone_number.blank? ? nil : submitter_contact_phone_number),
          (submitter_contact_fax_number.blank? ? nil : "FX"),
          (submitter_contact_fax_number.blank? ? nil : submitter_contact_fax_number)
  end

  def hcpcs_code(receivable, claim)
    if (claim.final_or_lupa_bill? and receivable.purpose == "Home Health Services")
      hcpcs = receivable.hcpcs_code
      nrs_code = hcpcs[-1]
      nrs_number = Invoice::NRS_NUMBER[nrs_code]
      hcpcs[4] = nrs_number if nrs_number
      hcpcs
    else
      receivable.hcpcs_code
    end
  end

  def interchange_control_header_start(b)
    b.ISA "00", nil, "00", nil,
          "ZZ", submitter_id,
          "ZZ", receiver_id,
          submission_date, submission_time, '^', "00501", "000000111", "1", "#{mode}", ':'
  end

  def functional_group_header_start(b)
    b.GS "HC", submitter_id, receiver_id, submission_date_century, submission_time, "1", "X", "005010X223A2"
  end

  def transaction_set_header_start(b)
    b.ST "837", "1234", "005010X223A2"
  end

  def beginning_of_hierarchical_transaction(b)
    b.BHT "0019", "00", "0000000333"*3, submission_date_century, submission_time, "CH"
  end

  def information_submitter_name(b)
    b.NM1 "41", "2", submitter_name, nil, nil, nil, nil, "46", submitter_id
  end

  def information_receiver_name(b)
    b.NM1 "40", "2", receiver_name, nil, nil, nil, nil, "46", receiver_id
  end

  def information_source_level(b, number, parent = nil)
    if parent.present?
      b.HL number, parent , "22", "0"
    else
      b.HL number, parent, "20", "1"
    end
  end

  def billing_provider_specialty_information(b)
    b.PRV "BI", "PXC", provider_taxonomy_code
  end

  def billing_provider_name(b)
    b.NM1 "85", "2", submitter_name, nil, nil, nil, nil, "XX", agency_npi_number
  end

  def billing_provider_address_line1(b)
    b.N3  billing_provider_address1
  end

  def billing_provider_address_line2(b)
    b.N4  billing_provider_city, billing_provider_state, billing_provider_zip_code
  end

  def billing_provider_tax_identification(b)
    b.REF "EI", fed_tax_number
  end

  def subscriber_information(b, claim)
    b.SBR "P", individual_relationship_code(claim), nil, nil, nil, nil, nil, nil, code_identifying_type_of_claim(claim)
  end

  def subscriber_name(b, claim)
    b.NM1 "IL", "1", subscriber_last_name(claim), subscriber_first_name(claim), nil, nil, nil, "MI", subscriber_identifier(claim)
  end

  def subscriber_address_line1(b, claim)
    b.N3 subscriber(claim).street_address, subscriber_suite_number(claim)
  end

  def subscriber_address_line2(b, claim)
    b.N4  subscriber(claim).city, subscriber(claim).state, subscriber(claim).zip_code
  end

  def subscriber_demographic_information(b, claim)
    b.DMG "D8", claim.patient_dob_century_format, claim.patient_gender
  end

  def subscriber_secondary_identification(b, claim)
    b.REF "SY", subscriber_ssn(claim)
  end

  def payer_name(b, claim)
    b.NM1 "PR", "2", claim.payer_name, nil, nil, nil, nil, "PI", claim.provider_number
  end

  def payer_address_line1(b, claim)
    b.N3 payer_address1(claim)
  end

  def payer_address_line2(b, claim)
    b.N4 payer_city(claim), payer_state(claim), payer_zip_code(claim)
  end

  def claim_information(b, claim)
    claim.receivables_for_print = true
    b.CLM claim_id(claim), claim.is_a?(PrivateInsuranceInvoice)? claim.total_amount_for_edi : claim.total_amount, nil, nil, b.composite("32", 'A', invoice_type(claim)), nil, 'A', 'Y','Y', nil
    claim.receivables_for_print = false
  end

  def statement_dates_segment(b, claim)
    b.DTP "434", "RD8", statement_covers_period(claim)
  end

  def admission_date_segment(b, claim)
    b.DTP "435", "DT", admission_date(claim)
  end

  def institutional_code(b, claim)
    b.CL1 claim.priority_of_visit, claim.src, claim.is_a?(PrivateInsuranceInvoice) ?  "44" : claim.status_of_discharge
  end

  def prior_authorization(b, claim)
    b.REF "G1", claim.is_a?(PrivateInsuranceInvoice) ? "11ST11ST11AAAAAAAA" : claim.treatment_authorization_codes
  end

  def medical_record_number(b, claim)
    b.REF "EA", claim.medical_record_number
  end

  def value_codes(b, claim)
    b.HI value_code(b, claim, 0), value_code(b, claim, 1),
         value_code(b, claim, 2), value_code(b, claim, 3),
         value_code(b, claim, 4), value_code(b, claim, 5)
  end

  def primary_diagnosis_code(b, icds)
    b.HI icd_code(b, icds[0], "BK")
  end

  def other_diagnosis_codes(b, icds)
    b.HI icd_code(b, icds[1], "BF"), icd_code(b, icds[2], "BF"), icd_code(b, icds[3], "BF"), icd_code(b, icds[4], "BF"),
         icd_code(b, icds[5], "BF"),icd_code(b, icds[6], "BF"), icd_code(b, icds[7], "BF"), icd_code(b, icds[8], "BF"),
         icd_code(b, icds[9], "BF"), icd_code(b, icds[10], "BF"), icd_code(b, icds[11], "BF")
  end

  def construct_edi_file
    config = Stupidedi::Config.default
    b = Stupidedi::Builder::BuilderDsl.build(config)

    interchange_control_header_start(b)
    functional_group_header_start(b)
    transaction_set_header_start(b)
    beginning_of_hierarchical_transaction(b)
    #Loop:2010AA
    information_submitter_name(b)
    submitter_contact_information(b)
    information_receiver_name(b)

    #Number of lines
    @num_of_transaction_sets = 5
    claims_segments(b)

    if errors.empty?
      transaction_set_header_end(b)
      functional_group_header_end(b)
      interchange_control_header_end(b)
    else
      return errors
    end

    ref = get_file_name(".txt")
    file_name = "#{Rails.root}/tmp/#{ref}"

    b.machine.zipper.tap do |z|
      separators =
          Stupidedi::Reader::Separators.build :segment    => "~\n",
                                              :element    => "*",
                                              :component  => ":",
                                              :repetition => "^"

      w = Stupidedi::Writer::Default.new(z.root, separators)

      File.open(file_name, "w") {|f| w.write(f) }
    end
    errors.empty? ? Rails.application.routes.url_helpers.export_claims_file_path(ref) : errors
  end

  def claims_segments(b)
    hl_count = 0
    claims.each do |claim|
      begin
        hl_count += 1
        information_source_level(b, hl_count)
        billing_provider_specialty_information(b)

        billing_provider_name(b)
        billing_provider_address_line1(b)
        billing_provider_address_line2(b)
        billing_provider_tax_identification(b)
        parent_hl = hl_count
        hl_count += 1
        information_source_level(b, hl_count, parent_hl)
        subscriber_information(b, claim)
        subscriber_name(b, claim)
        subscriber_address_line1(b, claim)
        subscriber_address_line2(b, claim)
        subscriber_demographic_information(b, claim)
        # subscriber_secondary_identification(b, claim)

        #loop2010BB
        payer_name(b, claim)
        payer_address_line1(b, claim)
        payer_address_line2(b, claim)

        #loop2300
        claim_information(b, claim)
        statement_dates_segment(b, claim)
        admission_date_segment(b, claim)
        institutional_code(b, claim)
        prior_authorization(b, claim)
        medical_record_number(b, claim)
        value_codes(b, claim)

        #ICD9 Diagnosis Codes
        icds = claim.icd_9
        primary_diagnosis_code(b, icds)
        other_diagnosis_codes(b, icds)

        transfer_from_hha(b, claim)
        #loop2310A ATTENDING PROVIDER INFORMATION
        attending_provider_name(b, claim)

        #loop2400 SERVICE LINES
        claim_services(b, claim)
      rescue Exception => e
        debug_log e.message
        errors << [claim.invoice_number, e.message]
        return errors
      end
    end
  end

  def transfer_from_hha(b, claim)
    if claim.transfer_from_hha.present?
      b.HI b.composite('BG', claim.transfer_from_hha)
      @num_of_transaction_sets += 1
    end
  end

  def attending_provider_name(b, claim)
    b.NM1 "71", "1", claim.primary_physician_last_name, claim.primary_physician_first_name,
          claim.primary_physician_middle_initials, nil, nil, "XX", claim.primary_physician_npi
  end

  def claim_services(b, claim)
    receivables = if claim.is_a?(PrivateInsuranceInvoice)                    
                    private_receivables.where(["invoice_id = ?", claim.id])
                  else
                    claim.receivables
                  end
    if claim.final_or_lupa_bill?
      filtered_receivables = receivables.where("source_type = 'TreatmentVisit'").reorder("receivable_date")
      qcode = claim.create_qcode_receivable(filtered_receivables.first)
      receivables = receivables.insert(1, qcode)
    end
    receivables.each_with_index do |receivable, index|
      b.LX "#{index+1}"
      service_info(b, receivable, claim)
      service_date(b, receivable)
    end
    # 26 is number of static lines per claim
    @num_of_transaction_sets += (25 + (claim.is_a?(PrivateInsuranceInvoice) ? receivables.size * 3 : claim.receivables.size * 3))
  end

  def service_date(b, service)
    b.DTP "472", "D8", service.receivable_date.strftime("%Y%m%d")
  end

  def service_info(b, receivable, claim)
    if receivable.purpose == "Home Health Services"
      b.SV2 receivable.revenue_code, b.composite("HP","#{hcpcs_code(receivable, claim)}"), receivable.receivable_amount,
            "UN", receivable.service_units
    elsif receivable.hcpcs_code == 'Q5009'
      description = 'Hospice or home health care provided in place not otherwise specified (nos)'
      b.SV2 receivable.revenue_code, b.composite("HC","#{hcpcs_code(receivable, claim)}",nil,nil,nil,nil,"#{description}"), receivable.receivable_amount,
            "UN", receivable.service_units
    else
      b.SV2 receivable.revenue_code, b.composite("HC","#{hcpcs_code(receivable, claim)}"), receivable.receivable_amount,
            "UN", receivable.service_units
    end

  end

  def transaction_set_header_end(b)
    b.SE num_of_transaction_sets + 1, "1234"
  end

  def functional_group_header_end(b)
    b.GE 1, "1"
  end

  def interchange_control_header_end(b)
    b.IEA 1, "000000111"
  end

end