require 'nokogiri'
module EDIAndHETSMap
  include ActionView::Helpers::NumberHelper

  def edi_2_xml edi
    Rjb::load(ENV['CLASS_PATH'], [ENV['JVM_ARGS']]) unless Rjb::loaded?
    edi_2_xml_klass = Rjb::import('com.berryworks.edireader.demo.EDItoXML')
    input_file = nil
    output_file = nil
    begin
      input_file = Tempfile.new('edi')
      output_file = Tempfile.new('edixml')
      input_file.write edi
      input_file.close
      output_file.close
      edi_2_xml_klass.main([input_file.path, '-o', output_file.path])
      xml = File.read(output_file.path)
      File.open(File.join(ENV['HOME'], "last_edi_xml_#{Org.current.id}.xml"), 'w') {|f| f.puts xml} if Rails.env=="development"
      return xml
    ensure
      input_file.unlink if input_file
      output_file.unlink if output_file
    end
  end

  def get_nokogiri_document(xml_content)
    Nokogiri::XML(xml_content) do |config|
      config.options = Nokogiri::XML::ParseOptions::NOBLANKS
    end
  end

  def active_periods
    ['1', '2', '3', '4', '5']
  end

  def inactive_periods
    ['6', '7', '8']
  end

  def deductibles
    ['C']
  end

  def rehabilitation_services
    ['F']
  end

  def theraphy_services
    ['D']
  end

  def blood_deductible
    ['E']
  end

  def home_health_and_hospice
    ['X']
  end

  def co_insurance
    ['A']
  end

  def error_code_display(doc)
    errors_list = []
    error_segments = doc.css("segment[Id='AAA']")
    if error_segments.size > 0
      error_segments.each do |aaa|
        code = aaa.css("element[Id='AAA03']").text
        errors_list << code
      end
    end
    errors_list
  end

  def connection_error_list(doc)
    errors_list = []
    error_codes = doc.css("code")
    error_codes.each do |code|
      error_message = code.next_element.text
      errors_list << {code: code.text, message: error_message}
    end
    errors_list
  end

  def requested_dates_display
    "#{requested_past_date.strftime("%m/%d/%Y")}-#{requested_future_date.strftime("%m/%d/%Y")}"
  end

  def requested_dates
    "#{format_date(requested_past_date)}-#{format_date(requested_future_date)}"
  end

  def requested_past_date
    Date.today - 13.months
  end

  def requested_future_date
    Date.today + 4.months
  end

  def format_date(date)
    date.strftime("%Y%m%d") if date.present?
  end



  def hcpcs_codes_list
    {"76977" => "Ultrasound Bone Density Measurement",
     "77057" => "Mammogram, screening",
     "77078" => "Computed tomography, bone mineral density study",
     "77080" => "Axial skelton",
     "77081" => "Appendicular skeleton",
     "80061" => "Lipid Panel",
     "82270" => "Colorectal cancer screening",
     "82465" => "High density cholesterol",
     "82947" => "Glucose; quantitative, blood",
     "82950" => "Post-glucose dose",
     "82951" => "Tolerance test (GTT)",
     "83718" => "Lipoprotein, direct measurement",
     "84478" => "Triglycerides",
     "90669" => "Pneumococcal conjugate vaccine, 5-valent",
     "90670" => "Pneumococcal conjugate vaccine, 13-valent",
     "90732" => "Pneumococcal polysaccharide vaccine, 23-valent",
     "G0101" => "Cancer screening: pelvic/breast exam",
     "G0102" => "Prostate cancer: digital rectal examination",
     "G0103" => "Prostate cancer: prostate specific antigen test",
     "G0104" => "Colorectal cancer screening: flexi sigmoidoscopy",
     "G0105" => "Colorectal scrn: high risk individual",
     "G0106" => "Colorectal cancer screen: barium enema",
     "G0117" => "Glaucoma scrn hgh risk direc by optometrist",
     "G0118" => "Glaucoma scrn hgh risk direc",
     "G0120" => "Colorectal ca scrn: barium enema",
     "G0121" => "Colorectal ca scrn not hi rsk ind",
     "G0123" => "Screen cerv/vag thin layer",
     "G0130" => "Single energy x-ray study" ,
     "G0143" => "Scrn cervical/vaginal cyto, thinlayer,rescr",
     "G0144" => "Scrn cervical/vaginal cyto, thinlayer,rescr",
     "G0145" => "Scrn cervical/vaginal cyto, thinlayer,rescr",
     "G0147" => "Scrn cervical/vaginal cyto, automated sys",
     "G0148" => "Scrn cervical/vaginal cyto, autosys, rescr",
     "G0202" => "Screening mammography digital",
     "G0328" => "Fecal blood scrn immunoassay",
     "G0389" => "Ultrasound exam AAA screen",
     "G0402" => "Initial preventive exam",
     "G0403" => "Ekg for initial prevent exam",
     "G0404" => "Ekg tracing for initial prev",
     "G0405" => "Ekg interpret & report preve",
     "G0438" => "Ppps, initial visit",
     "G0439" => "Ppps, subseq visit",
     "G0444" => "Depression screen annual",
     "G0445" => "High inten beh couns std 30m",
     "G0446" => "Intens behave ther cardio dx",
     "G0447" => "Behavior counsel obesity 15m",
     "P3000" => "Screen pap by tech w md supv",
     "Q0091" => "Obtaining screen pap smear"}

  end

  def revocation_code_description
    {"0" => "Not revoked", "1" => "Revoked by notice of revocation",
    "2" => "Revoked by notice of revocation with a non-payment code of 'N' and an occurrence code of '42'",
    "3" => "Revoked by a Hospice claim with an occurrence code of '23'"}
  end

  def plan_coverage_map
    {"HM" => "Health Maintenance Organization Medicare Non Risk - HM", "HN" => "Health Maintenance Organization Medicare Risk - HN",
     "IN" => "Indemnity - IN", "PR" => "Preferred Provider Organization - PR", "PS" => "Point of Service - PS",
     "Part D" => "Pharmacy - Part D", "OT" => "OT - Prescription Drug Coverage"}
  end

  def service_type_hash
    {"14" =>	"Renal Supplies in the Home",
    "15" =>	"Alternate Method Dialysis",
    "16" => "Chronic Renal Disease (CRD) Equipment"
    }
  end

  def beneficiary_information(doc, agency_name)
    beneficiary_information = element(doc, 'NM101', 'IL').first.parent
    last_name = element_value(beneficiary_information, "NM103")
    first_name = element_value(beneficiary_information, "NM104")
    hicn = element_value(beneficiary_information, "NM109")

    address_details1 = beneficiary_information.next_element
    if address_details1
      address_line1, address_line2 = address(address_details1)
    end

    address_details2 = address_details1.next_element if address_details1
    if address_details2
      city, state, zip_code = city_state_zip(address_details2)
    end

    dob_gender = address_details2.next_element if address_details2
    if dob_gender
      dob = element_value(dob_gender, 'DMG02')
      gender = element_value(dob_gender, 'DMG03')
    end

    date_of_death = element(doc, 'DTP01', '442').first
    if date_of_death
      date_of_death = date_of_death.parent
      dod = element_value(date_of_death, 'DTP03')
      dod_value = date_format(dod) if dod
    end


    {beneficiary: {last_name: last_name, first_name: first_name, date_of_birth: date_format(dob), sex: gender,
    hicn: hicn, agency_name: agency_name,  requested_dates: requested_dates_display},
    beneficiary_address_details: {address_line_1: address_line1, address_line_2: address_line2, city: city,
    state: state, zip_code: zip_code}, date_of_death: dod_value}

  end

  def part_a_eligibilities(doc)
    effective_date, termination_date = eligibility(doc, "a")
    { part_a_eligibility: {part_a_effective_date: effective_date, part_a_termination_date: termination_date}}
  end

  def eligibility(doc, type)
    selected_eb_elements = active_periods.collect {|code| ebs(doc, code) if element_exists?(doc, "EB01", code) }.flatten.compact

    selected_eb_elements.select! {|eb| (type == "a") ? medicare_part_a?(eb) : medicare_part_b?(eb)}

    selected_dtp_elements = []
    selected_eb_elements.each{|eb|
      dtp = eb.next_element

      while dtp.present? and dtp01_text_contains?(dtp, '291').present?
        selected_dtp_elements << dtp
        dtp = dtp.next_element
      end
    }
    dtp = selected_dtp_elements.first
    if dtp.nil?
      selected_eb_elements = ebs(doc, '6')
      selected_eb_elements = selected_eb_elements.select{|eb| (type == "a") ? medicare_part_a?(eb) : medicare_part_b?(eb) }
      selected_eb_elements = selected_eb_elements.reject{|eb| element_exists?(eb.next_element, "DTP01") }
      eb_element = selected_eb_elements.first
      eb_element.present? ? ["The Medicare Beneficiary Part #{type.upcase} entitlement had not yet
begun or Terminated as of the requested date(s) of service."] : []
    else
      if element_value(dtp, "DTP02") == "RD8"
        dates = get_dates_from_range(dtp_value(dtp))
        [date_format(dates[0]), date_format(dates[1])]
      else
        [date_format(dtp_value(dtp))]
      end
    end
  end

  def current_entitlement(doc)
    part_a = part_a_eligibilities(doc)
    part_b = part_b_eligibilities(doc)
    if part_a
      part_a.merge!((part_b))
    else
      part_b
    end
  end

  def part_b_eligibilities(doc)
    effective_date, termination_date = eligibility(doc, "b")
    {part_b_eligibility: { part_b_effective_date: effective_date, part_b_termination_date: termination_date}}
  end

  def esrd(doc)
    selected_eb_elements = ebs(doc, 'D')
    selected_eb_elements.select!{|eb|
      res = false
      res = ["14", "15"].include?(element_value(eb, "EB03")) if element_exists?(eb, "EB03")
      res = (res and (medicare_part_a?(eb) or medicare_part_b?(eb)))
      dtp = eb.next_element
      res = (res and (dtp01_text_contains?(dtp, "356") or dtp01_text_contains?(dtp, "096")))
      res
    }
    selected_eb_elements.collect{|eb|
      service_type_code = element_value(eb, "EB03")
      dtp = eb.next_element
      effective_date = nil
      discharge_date = nil

      dtp01_text_contains?(dtp, "356") ? (effective_date = dtp_value(dtp)) : (discharge_date = dtp_value(dtp))

      {esrd_code: service_type_code + " - " + service_type_hash[service_type_code] ,
               esrd_code_effective_date: date_format(effective_date), transplant_discharge_date: date_format(discharge_date)}
    }
  end

  def part_a_deductibles(doc)
    selected_eb_elements = deductibles.collect {|code| ebs(doc, code) if element_exists?(doc, 'EB01', code) }.flatten.compact
    selected_eb03_30_elements = selected_eb_elements.select{|eb| medicare_part_a?(eb) and element_exists?(eb, 'EB03', '30')}
    days_base = selected_eb03_30_elements.select{|eb| (element_exists?(eb, "EB06", "26"))}
    days_remaining = selected_eb03_30_elements.select{|eb| (element_exists?(eb, "EB06", "29"))}
    selected_eb03_42_45_elements = selected_eb_elements.select{|eb| medicare_part_a?(eb) and
        element_exists?(eb, 'EB03', '42') and element_exists?(eb, 'EB03', '45') }

    spell_remainings = []
    deductibles = []
    days_remaining.each do |eb|
      dtp = eb.next_element
      if dtp.present?
        dates = get_dates_from_range(dtp_value(dtp))
        start_date = dates[0].to_date
        to_date = dates[1].to_date
        dates_difference = to_date.month - start_date.month
        if dates_difference < 11
          spell_remainings << eb
        end
      end
    end

    days_base.each_with_index do |eb, i|
      dtp = eb.next_element
      base_amount = element_value(eb, 'EB07')
      remaining_eb = days_remaining[i]
      remaining_amount = formatted_amount("#{element_value(remaining_eb, 'EB07')}")
      if dtp.present?
       deductibles << {deductible_year: from_and_to_date_format(dtp_value(dtp)) , base_amount_deductible_for_year: base_amount,
                                      cash_deductible_remaining: "$"+ remaining_amount, doeba: nil, dolba: nil}
      end
    end

    spell_remainings.each do |eb|
      dtp = eb.next_element
      remaining_amount = formatted_amount("#{element_value(eb, 'EB07')}")
      if dtp.present?
        dates = get_dates_from_range(dtp_value(dtp))
        deductibles << {deductible_year: from_and_to_date_format(dtp_value(dtp)) , base_amount_deductible_for_year: nil,
                        cash_deductible_remaining: "$"+ remaining_amount, doeba: date_format(dates[0]), dolba: date_format(dates[1])}
      end
    end

    selected_eb03_42_45_elements.each {|eb|
      dtp = eb.next_element
      base_amount = element_value(eb, 'EB07')
      if dtp.present?
        deductibles << {deductible_year: from_and_to_date_format(dtp_value(dtp)) , base_amount_deductible_for_year: base_amount,
                        cash_deductible_remaining: nil, doeba: nil, dolba: nil}
      end
    }
    deductibles.uniq
  end

  def formatted_amount(amount)
    number_to_currency(amount, :format => "%n", :delimiter => "")
  end

  def co_insurance_details(doc)
    selected_eb_elements = co_insurance.collect {|code| ebs(doc, code) if element_exists?(doc, 'EB01', code) }.flatten.compact

    selected_eb_elements.select!{|e| medicare_part_b?(e) and element_exists?(e, 'EB06', '27')}

    selected_eb_elements.collect do |eb|
      dtp = eb.next_element
      date = get_dates_from_range(dtp_value(dtp))
      co_insurance_percent = element_value(eb, 'EB08')
      co_insurance_percent = formatted_amount(co_insurance_percent) + "%"
      hcpcs_code = ''
      insurance_type = ''
      if element_exists?(eb, "EB13")
        hcpcs_code = sub_element_value(eb, '2')
      elsif co_insurance_percent != "0.00%"
        insurance_type = element_exists?(eb, "EB03", "30") ? "Plan Level" : "Mental Health"
      end

      {co_insurance_percent: co_insurance_percent, co_insurance_type: insurance_type,
       start_date: date_format(date.first), end_date: date_format(date.last),
       hcpcs: hcpcs_code_description(hcpcs_code) }
    end
  end

  def element_exists?(parent, number, text = nil)
    res = text.nil? ? element(parent, number) : element(parent, number, text)
    res.size > 0
  end

  def element(parent, number, text = nil)
    text.nil? ? parent.css("element[Id='#{number}']") : parent.css("element[Id='#{number}']:contains('#{text}')")
  end

  def sub_element(parent, number, text = nil)
    text.nil? ? parent.css("subelement[Sequence='#{number}']") : parent.css("subelement[Sequence='#{number}']:contains('#{text}')")
  end

  def sub_element_value(parent, number, text = nil)
    ele = sub_element(parent, number, text)
    ele.text
  end

  def deductibles_list(doc)
    list = {part_a_deductibles: part_a_deductibles(doc).reject{|x| x.blank?}}
    list.merge!({part_b_deductibles: part_b_deductibles(doc).reject{|x| x.blank?}})
    list.merge!({co_insurance_details: co_insurance_details(doc)})
    list.merge!(blood_deductibles: blood_deductibles(doc))
    list.merge!(occupational_deductibles: occupational_theraphy_cap(doc))
    list.merge!(physical_and_speech_therapy_caps: physical_and_speech_theraphy_cap(doc))
  end


  def rehabilations(doc)
    pulmonary_list = {hcpcs_codes: nil}.merge!(pulmonary_rehabilitation(doc))
    cardiac_list = {hcpcs_codes: nil}.merge!(cardiac_rehabilitation(doc))
    list = {pulmonary_rehabilitation_sessions_remaining: pulmonary_list}
    list.merge!(cardiac_list)
  end

  def part_b_deductibles(doc)
    selected_eb_elements = deductibles.collect {|code| ebs(doc, code) if element_exists?(doc, "EB01", code) }.flatten.compact

    selected_eb_elements.select!{|e| medicare_part_b?(e) }

    base_elements = selected_eb_elements.select {|eb| element_exists?(eb, 'EB06', '23') }

    remaining_elements = selected_eb_elements.select {|eb| element_exists?(eb, 'EB06', '29') }

    part_b_deductibles_list = []

    count = 0
    base_elements.each do |base_element|
      dtp = base_element.next_element
      base_amount = element_value(base_element, 'EB07')
      rec = {deductible_year: from_and_to_date_format(dtp_value(dtp)), base_amount_deductible_for_year: base_amount}
      if hcpcs_present?(base_element)
        hcpcs_code = sub_element_value(base_element, '2')
        rec[:hcpcs] = hcpcs_code_description(hcpcs_code)
      end
      if base_amount == '0'
        rec[:cash_deductible_remaining] = "NA"
      else
        remaining_element = remaining_elements[count]
        count += 1
        rem_amt = formatted_amount("#{element_value(remaining_element, 'EB07')}")
        rec[:cash_deductible_remaining] = "$#{rem_amt}"
      end

      part_b_deductibles_list << rec
    end
    part_b_deductibles_list
  end

  def hcpcs_present?(eb_segment)
    element_exists?(eb_segment, "EB13")
  end

  def blood_deductibles(doc)
    selected_eb_elements = blood_deductible.collect {|code| ebs(doc, code) if element_exists?(doc, "EB01", code) }.flatten.compact
    selected_eb_elements.select! {|eb|
      element_exists?(eb, 'EB03', '10') and element_exists?(eb, 'EB06', '23') and element_exists?(eb, 'EB09', 'DB') }

    selected_eb_elements.collect{|eb|
      hsd = eb.next_element
      dtp = hsd.next_element
      {deductible_year: from_and_to_date_format(dtp_value(dtp)) , base_units_per_year: element_value(eb, 'EB10') ,
        blood_deductibles_units_remaining: element_value(hsd, 'HSD02') }
    }

  end

  def pulmonary_rehabilitation(doc)
    selected_eb_elements = rehabilitation_services.collect {|code| ebs(doc, code) if element_exists?(doc, "EB01", code) }.flatten.compact

    selected_eb_elements.select! {|eb| medicare_part_b?(eb) and element_exists?(eb, 'EB06', '29') and element_exists?(eb, 'EB09', 'CA') }

    pulmonary_rehabilitation = {:professional_sessions => nil, :technical_sessions => nil}
    selected_eb_elements.each{ |eb|
      quantity = element_value(eb, 'EB10')
      msg = eb.next_element
      message = element_value(msg, 'MSG01')
      if message == 'Professional'
        pulmonary_rehabilitation.merge!({:professional_sessions => quantity})
      else
        pulmonary_rehabilitation.merge!({:technical_sessions => quantity})
      end
    }
    pulmonary_rehabilitation

  end

  def occupational_theraphy_cap(doc)
    selected_eb_elements = theraphy_services.collect {|code| ebs(doc, code) if element_exists?(doc, "EB01", code) }.flatten.compact

    selected_eb_elements.select! {|eb| (not element_exists?(eb, 'EB03', 'AE')) }
    theraphy_list(selected_eb_elements, "occupational")
  end

  def physical_and_speech_theraphy_cap(doc)
    selected_eb_elements = theraphy_services.collect {|code| ebs(doc, code) if element_exists?(doc, "EB01", code) }.flatten.compact

    selected_eb_elements.select! {|eb| element_exists?(eb, 'EB03', 'AE') }
    theraphy_list(selected_eb_elements, "physical")
  end


  def theraphy_list(selected_eb_elements, flag)
    theraphy_list = []
    selected_eb_elements.select! {|eb| medicare_part_b?(eb)}

    selected_eb_elements.each{|eb|
      eb07_element = element(eb, 'EB07')
      amount = eb07_element.text if eb07_element.present?
      dtp = eb.next_element
      while dtp01_text_contains?(dtp, '292').present?
        theraphy_list << {deductible_year: from_and_to_date_format(dtp_value(dtp)), :"#{flag}_therapy_remaining" => amount}
        dtp = dtp.next_element
      end
    }
    theraphy_list
  end

  def cardiac_rehabilitation(doc)
    selected_eb_elements = rehabilitation_services.collect {|code| ebs(doc, code) if element_exists?(doc, "EB01", code) }.flatten.compact

    selected_eb_elements.select! {|eb| medicare_part_b?(eb) and element_exists?(eb, 'EB09', '99') }

    cardiac_rehabilitation_list = {:professional_sessions => nil, :technical_sessions => nil}
    intensive_cardiac_rehabilitation_list = {:professional_sessions => nil, :technical_sessions => nil}
    selected_eb_elements.each{ |eb|
      quantity1 = element_value(eb, 'EB10')
      message1 = element_value(eb.next_element, 'MSG01')

      if (message1.gsub /\W/, '').include?("IntensiveCardiacRehabilitationProfessional")
        intensive_cardiac_rehabilitation_list.merge!({:professional_sessions => quantity1})
      elsif (message1.gsub /\W/, '').include?("IntensiveCardiacRehabilitationTechnical")
        intensive_cardiac_rehabilitation_list.merge!({:technical_sessions => quantity1 })
      elsif message1.include?("Professional")
        cardiac_rehabilitation_list.merge!({:professional_sessions => quantity1})
      else message1.include?("Technical")
        cardiac_rehabilitation_list.merge!({:technical_sessions => quantity1})
      end
    }
    {cardiac_rehabilitation_sessions_applied: cardiac_rehabilitation_list, intensive_cardiac_rehabilitation_sessions_applied: intensive_cardiac_rehabilitation_list}
  end

  def home_health_care(doc)
    selected_eb_elements = home_health_and_hospice.collect {|code| ebs(doc, code) if element_exists?(doc, "EB01", code) }.flatten.compact
    selected_eb_elements.select! {|eb| element_exists?(eb, 'EB06', '26') }
    selected_eb_elements.select! {|eb| dtp01_text_contains?(eb.next_element, "472") or dtp01_text_contains?(eb.next_element, "193") or
        dtp01_text_contains?(eb.next_element, "194") }

    hhcs = []
    selected_eb_elements.each do |eb|
      hhc = {start_date: nil, end_date: nil, contracter_name: nil,
             intermediary_number: nil, provider_number: nil, earliest_billing_date: nil, latest_billing_date: nil }
      dtp = eb.next_element
      while (dtp01_text_contains?(dtp, "472") or dtp01_text_contains?(dtp, "193") or dtp01_text_contains?(dtp, "194"))
        if dtp01_text_contains?(dtp, "472")
          date = get_dates_from_range(dtp_value(dtp))
          hhc.merge!({ start_date: date_format(date.first), end_date: date_format(date.last) })
        elsif dtp01_text_contains?(dtp, "193")
          hhc.merge!({earliest_billing_date: date_format(dtp_value(dtp))})
        elsif dtp01_text_contains?(dtp, "194")
          hhc.merge!({latest_billing_date: date_format(dtp_value(dtp))})
        end
        dtp = dtp.next_element
      end
      ls = dtp
      nm1 = ls.next_element

      while (element(nm1, 'NM101') and ["PR", "1P"].include?(element_value(nm1, 'NM101')))
        if nm1.css("element[Id='NM101']").text == "PR"
          hhc[:contractor_name] = element_value(nm1, 'NM103')
          hhc[:intermediary_number] = element_value(nm1, 'NM109')
        else
          npi = element_value(nm1, 'NM109')
          hhc[:provider_number] = get_provider_name(npi)
        end
        nm1 = nm1.next_element
      end
      hhcs << hhc
    end

    {home_health_episodes: hhcs}
  end

  def home_health_re_certifications(doc)
    h = home_health_certification(doc)
    {home_health_recertifications: h[:recertifications]}
  end

  def home_health_certifications(doc)
    h = home_health_certification(doc)
    {home_health_certifications: h[:certifications]}
  end

  def home_health_certification(doc)
    selected_eb_elements = home_health_and_hospice.collect {|code| ebs(doc, code) if element_exists?(doc, "EB01", code) }.flatten.compact

    selected_eb_elements.select! {|eb| element_exists?(eb, 'EB13') }
    selected_eb_elements.select! {|eb| sub_element_value(element(eb, 'EB13'), '1') == "HC" }
    certification_eb_list = selected_eb_elements.select {|eb| sub_element_value(element(eb, 'EB13'), '2') == "G0180" }
    recertification_eb_list = selected_eb_elements - certification_eb_list

    certification_dates = certification_dates(certification_eb_list)
    recertification_dates = certification_dates(recertification_eb_list)

    {certifications: {plan_of_care_certifications: certification_dates}, recertifications: {plan_of_care_recertifications: recertification_dates}}
  end

  def certification_dates(recertification_eb_list)
    list = []
    recertification_eb_list.each do |eb|
      hcpcs_code = sub_element_value(eb, '2')
      dtp = eb.next_element
      while dtp01_text_contains?(dtp, "193")
        list << {hcpcs: hcpcs_code, from_date: date_format(dtp_value(dtp))}
        dtp = dtp.next_element
      end
    end
    list
  end

  def hospice_information(doc)
    selected_eb_elements = home_health_and_hospice.collect {|code| ebs(doc, code) if element_exists?(doc, "EB01", code) }.flatten.compact

    selected_eb_elements.select!{|eb| medicare_part_a?(eb) and element(eb, 'EB06') and
        element_value(eb, 'EB06') == "26" and dtp01_text_contains?(eb.next_element, "292")}

    hospice_informations = []
    selected_eb_elements.each do |eb|
      hi = {}
      dtp = eb.next_element
      next unless dtp01_text_contains?(dtp, "292")
      dates = get_dates_from_range(dtp_value(dtp))
      hi[:start_date] = date_format(dates[0])
      hi[:termination_date] = date_format(dates[1])
      msg = dtp.next_element
      next unless element_exists?(msg, 'MSG01')
      revocation_code = element_value(msg, 'MSG01')[-1]
      hi[:revocation_indicator] = revocation_code + " - " + revocation_code_description[revocation_code]
      ls = msg.next_element
      nm1 = ls.next_element
      npi = element_value(nm1, 'NM109')
      hi[:provider_id] = get_provider_name(npi)
      le = nm1.next_element
      eb = le.next_element
      if element(eb, 'EB01', 'D') and element(eb, 'EB04', 'MA') and
          element(eb, 'EB06', '26') and element(eb, 'EB09', '99')
        hi[:hospice_occurence_count] = element_value(eb, 'EB10')
      end
      hospice_informations << hi
    end
    hospice_informations
  end

  def get_provider_name(npi)
    name = @npi_list[npi]
    if name.present?
      name
    else
      npi_to_name = npi
      begin
        npi_to_name = "#{NPIToName.new(npi).get_name}(#{npi})"
      rescue Exception
        npi_to_name = npi
      end
      @npi_list[npi] = npi_to_name
      @npi_list[npi]
    end
  end

  def plan_coverage(doc)
    selected_eb_elements = element(doc, 'EB01', 'R').collect{|e| e.parent }
    selected_eb_elements.select!{|eb|
      eb04 = element(eb, 'EB04')
      res = eb04.empty? ? true : plan_coverage_map[eb04.text].present?
      (res and element_value(eb.next_element, 'REF01') == "18")
    }

    plan_coverage_list = []
    selected_eb_elements.each do |eb|
      ref = eb.next_element
      dtp = ref.next_element

      plan_type = part_d_plan_coverage?(eb) ? "Pharmacy - Part D" : plan_coverage_map[element_value(eb, 'EB04')]
      contract_and_plan_number = element_value(ref, 'REF02')
      enrollment_date = date_format(element_value(dtp, 'DTP03'))

      msg = element(dtp.next_element, 'MSG01')
      mco_msg = msg.present? ? msg.text[-1] : nil

      ls = msg.present? ? msg.first.parent.next_element : dtp.next_element
      nm1 = ls.next_element
      plan_name = element_value(nm1, 'NM103')

      n3 = nm1.next_element
      address_line_1, address_line_2 = address(n3)

      n4 = n3.next_element
      city, state, zip_code = city_state_zip(n4)

      per = n4.next_element
      phone_number = nil
      contract_website = nil
      if per.present?
        phone_number, contract_website = per_info_for_plan_coverage(per)
      end
      plan_coverage_list << {type: plan_type, plan_name: plan_name, id_code_and_contractor_number: contract_and_plan_number, effective_date: enrollment_date,
                             option_code: mco_msg, termination_date: nil, contract_website_address: contract_website,
                             phone_number: phone_number, address_line_1: address_line_1, address_line_2: address_line_2,
                             city: city, state: state, zip_code: zip_code}
    end
    plan_coverage_list
  end

  def address(n3)
    [element_value(n3, 'N301'), element_value(n3, 'N302')]
  end

  def city_state_zip(n4)
    [element_value(n4, 'N401'), element_value(n4, 'N402'), element_value(n4, 'N403')]
  end

  def per_info_for_plan_coverage(per)
    per03 = element(per, 'PER03')
    per04 = element(per, 'PER04')
    per05 = element(per, 'PER05')
    per06 = element(per, 'PER06')

    phone_number = per04.text if per03.present? and per03.text == 'TE'
    contract_website = per04.text if per03.present? and per03.text == 'UR'
    phone_number = per06.text if per05.present? and per05.text == 'TE'
    contract_website = per06.text if per05.present? and per05.text == 'UR'

    [phone_number, contract_website]
  end

  def part_d_plan_coverage?(eb)
    element(eb, 'EB04').size == 0
  end

  def date_format(date, format = "yyyymmdd")
    if format == "yyyymmdd"
      Date.strptime(date, "%Y%m%d").strftime("%m/%d/%Y") if date.present?
    end
  end

  def from_and_to_date_format(date, format = "yyyymmdd")
    dates = date.split('-')
    "#{date_format(dates[0])} - #{date_format(dates[1])}"
  end

  def ebs(element, text)
    element(element, 'EB01', text).collect{|eb04| eb04.parent }
  end

  def dtp01_text_contains?(element, text)
    element_exists?(element, 'DTP01', text)
  end

  def dtp_value(dtp)
    element_value(dtp, 'DTP03')
  end

  def eb04_text_contains?(element, text=nil)
    if text.nil?
      element(element, 'EB04').size == 0
    else
      element_exists?(element, 'EB04', text)
    end
  end

  def medicare_part_a?(eb)
    element_exists?(eb, "EB04", "MA")
  end

  def medicare_part_b?(eb)
    element_exists?(eb, "EB04", "MB")
  end


  def find_ebo1_elements(doc, conditions, text_includes)
    text_includes.collect {|text| element('EB01', text) }.flatten
  end

  def eligibility_inactive_periods(doc)
    {part_a_inactive_periods: part_a_inactive_periods(doc), part_b_inactive_periods: part_b_inactive_periods(doc)}
  end

  def part_a_inactive_periods(doc)
    selected_eb_elements = inactive_periods.collect{ |code| ebs(doc, code) if element_exists?(doc, 'EB01', code) }.flatten.compact

    selected_eb_elements.select! {|eb| medicare_part_a?(eb) or element(eb, "EB04").size == 0 }
    selected_dtp_elements = []
    selected_eb_elements.each{|eb|
      dtp = eb.next_element
      while dtp.present? and dtp01_text_contains?(dtp, '307')
        selected_dtp_elements << dtp
        dtp = dtp.next_element
      end
    }
    list = selected_dtp_elements.collect{|dtp|
      date = dtp_value(dtp)
      date = get_dates_from_range(date)
      { effective_date: date_format(date.first), termination_date: date_format(date.last) }
    }.uniq
    list
  end

  def part_b_inactive_periods(doc)
    selected_eb_elements = inactive_periods.collect{ |code| ebs(doc, code) if element_exists?(doc, "EB01", code) }.flatten.compact
    selected_eb_elements.select! {|eb| medicare_part_b?(eb)}
    selected_dtp_elements = []
    selected_eb_elements.each{|eb|
      dtp = eb.next_element
      if dtp
        while dtp01_text_contains?(dtp, '307').present?
          selected_dtp_elements << dtp
          dtp = dtp.next_element
        end
      end
    }

   list = selected_dtp_elements.collect{|dtp|
      date = dtp_value(dtp)
      date = get_dates_from_range(date)
      { effective_date: date_format(date.first), termination_date: date_format(date.last) }
    }.uniq
    list
  end

  def smoking_cessions(doc)
    selected_eb_elements = ebs(doc, 'F')
    selected_eb_elements.select! {|eb| element(eb, 'EB03', '67')}
    selected_eb_elements.select! {|eb| medicare_part_b?(eb)}
    list = []
    selected_eb_elements.each{|eb|
      element = eb.next_element
      hsd = element(element, 'HSD01', 'VS')
      dtp = element(element, 'DTP01', '348')
      eb10 = element_value(element, 'EB10')
      if hsd.present?
        remaining_sessions = element_value(element, 'HSD02')
        list << {number_of_remaining_sessions: remaining_sessions, total_sessions: eb10}
      elsif dtp.present?
        date = element_value(dtp, 'DTP03')
        list << {remaining_sessions: nil, next_eligible_date: date_format(date)}
      end
    }
    {counselling_periods: list}
  end

  def msp_codes
    ['12', '13', '14', '15', '16', '41', '42', '43', '47', 'WC']
  end

  def get_dates_from_range(date)
    date.split("-")
  end

  def preventives(doc)
    selected_eb_elements = ebs(doc, 'D')
    selected_eb_elements.select! {|eb| medicare_part_b?(eb)}
    selected_dtp_elements = []
    eb13_codes = selected_eb_elements.collect{|eb| element(eb, 'EB13')}.flatten
    list = []
    eb13_codes.each{|eb13|
      eb13_2 = eb13.children.detect{|x| x.values == ["2"]}
      eb13_3 = eb13.children.detect{|x| x.values == ["3"]}
      eb = eb13.parent
      dtp = eb.next_element
      while dtp01_text_contains?(dtp, '348').present?
        selected_dtp_elements << dtp
        dtp = dtp.next_element
      end
      dates = selected_dtp_elements.collect{|dtp|
        date = dtp_value(dtp)
        if eb13_3.present?
          if eb13_3.text == "26"
            { professional_date: date_format(date)}
          elsif eb13_3.text == "TC"
            {technical_date: date_format(date)}
          end
        else
          {professional_date: date_format(date), technical_date: date_format(date)}
        end
      }.uniq
      list << {hcpcs: hcpcs_code_description(eb13_2.text)}.merge!(dates.first)
    }
    {preventive_services: list}
  end

  def inpatient_spell(doc, stc = [])
    selected_eb_elements = ebs(doc, 'B')
    selected_eb_elements.select!{|eb|
      res = false
      stc.each {|s| res = (res or element_exists?(eb, "EB03", s)) }
      res and medicare_part_a?(eb) and element_exists?(eb, "EB06", "7") }
    days_base = selected_eb_elements.select{|eb| (element_exists?(eb.next_element, "HSD05", "30") or
        element_exists?(eb.next_element, "HSD05", "31")) and element_exists?(eb.next_element, "HSD03", "DA")}
    days_remaining = selected_eb_elements.select{|eb| element_exists?(eb.next_element, "HSD05", "29") and
        element_exists?(eb.next_element, "HSD03", "DA")}

    plan_coverages = []
    add_on = days_base.length
    days_base.each_with_index do |eb, index|
      plan_coverage = {co_insurance_amount: element_value(eb, "EB07"), earliest_billing_date: nil, latest_billing_date: nil}
      hsd1 = eb.next_element
      element_exists?(hsd1, "HSD05", "30") ? from_day = element_value(hsd1, "HSD06") : to_day = element_value(hsd1, "HSD06")
      hsd2 = hsd1.next_element
      element_exists?(hsd2, "HSD05", "31") ? to_day = element_value(hsd2, "HSD06") : from_day = element_value(hsd2, "HSD06")
      plan_coverage[:max_allowed_days] = to_day.to_i - from_day.to_i

      hsd3 = hsd2.next_element
      dtp = hsd3.next_element
      plan_coverage[:calendar_year] = from_and_to_date_format(dtp_value(dtp))

      hdr_eb = days_remaining[index]
      hdr_hsd1 = hdr_eb.next_element
      plan_coverage[:remaining_days] = element_value(hdr_hsd1, "HSD06")

      #if DOEBA and DOLBA exists do this step
      hdr_eb = days_remaining[add_on + index]
      if hdr_eb
        hdr_hsd1 = hdr_eb.next_element
        plan_coverage[:remaining_days] = element_value(hdr_hsd1, "HSD06")
        if plan_coverage[:max_allowed_days].to_s != plan_coverage[:remaining_days].to_s
          hdr_hsd2 = hdr_hsd1.next_element
          dtp = hdr_hsd2.next_element
          dates = get_dates_from_range(dtp_value(dtp))
          plan_coverage[:earliest_billing_date] = date_format(dates[0])
          plan_coverage[:latest_billing_date] = date_format(dates[1])
        end
     end
      plan_coverages << plan_coverage
    end
    plan_coverages
  end

  def inpatient_hospital(doc)
    {inpatient_hospital_details: inpatient_spell(doc, ["30"])}
  end

  def inpatient_snf(doc)
    {snf_details: inpatient_spell(doc, ["AG"])}
  end

  def current_benifit_periods(doc)
    list = inpatient_hospital(doc).merge!(inpatient_snf(doc))
    list.merge!(life_time_reserve_days(doc))
    list.merge!(psychiatric_limitation_days(doc))
  end

  def life_time_reserve_days(doc)
    selected_eb_elements = ebs(doc, 'K')
    selected_eb_elements.select!{|eb| element_exists?(eb, "EB03", "30") and element_exists?(eb, "EB06",  "32") and medicare_part_a?(eb) }

    ltrds = []
    selected_eb_elements.each do |eb|
      ltrd = {}
      ltrd[:max_allowed_days] = element_value(eb, "EB10")
      eb2 = eb.next_element
      ltrd[:remaining_days] = element_value(eb2, "EB10")
      eb3 = eb2.next_element
      ltrd[:co_insurance_amount] = element_value(eb3, "EB07")
      dtp = eb3.next_element
      ltrd[:calendar_year] = from_and_to_date_format(dtp_value(dtp))

      ltrds << ltrd
    end
    {life_time_reserve_days_details: ltrds}
  end

  def psychiatric_limitation_days(doc)
    selected_eb_elements = ebs(doc, 'K')
    selected_eb_elements.select!{|eb| element_exists?(eb, "EB03", "A7") and element_exists?(eb, "EB06", "32")}

    plds = []
    selected_eb_elements.each do |eb|
      pld = {}
      pld[:base_days] = element_value(eb, "EB10")
      eb2 = eb.next_element
      pld[:remaining_days] = element_value(eb2, "EB10")
      plds << pld
    end
    {pshychiatric_limitation_days_details: plds}
  end

  def element_value(element, number, text = nil)
    ele = text.nil? ? element(element, number) : element(element, number, text)
    ele.text
  end


  def beneficiary_information_list(doc, agency_name)
    list = beneficiary_information(doc, agency_name)
    list.merge!({current_entitlement: current_entitlement(doc)})
    list.merge!({inactive_periods: eligibility_inactive_periods(doc)})
    list.merge!({esrd_details: esrd(doc)})
    list.merge!(deductibles_list(doc))
  end

  def medicare_secondary_payers(doc)
    selected_eb_elements = ebs(doc, 'R')
    selected_eb_elements.select! {|eb| element(eb, 'EB03', '30') }
    selected_eb_elements.select! {|eb| element_exists?(eb, 'EB04') and msp_codes.include?(element_value(eb, 'EB04')) }

    list = []
    selected_eb_elements.each do |eb|
      insurance_type_code = element_value(eb, 'EB04')
      ref01 = element(eb.next_element, 'REF01')
      ref = ref01.first.parent if ref01.present?
      if ref.present?
                dtp01 = element(ref.next_element, 'DTP01', '290')
                dtp02 = element(ref.next_element, 'DTP02')
                date = element_value(ref.next_element, 'DTP03')
              else
                dtp01 = element(eb.next_element, 'DTP01', '290')
                dtp02 = element(eb.next_element, 'DTP02')
                date = element_value(eb.next_element, 'DTP03')
              end
      dtp = dtp01.first.parent
      policy_number = element_value(ref, "REF02") if ref.present?

      dates = if dtp01
                if dtp02 and dtp02.text =="RD8"
                  date = get_dates_from_range(date)
                  dates = [date_format(date.first), date_format(date.last)]
                elsif dtp02 and dtp02.text == "D8"
                  dates = [date_format(date), '']
                end
              end
      msg = element(dtp.next_element, 'MSG01')
      mco_msg = msg.present? ? msg.text : nil

      ls = msg.present? ? msg.first.parent.next_element : dtp.next_element
      nm1 = ls.next_element
      insurance_name = element_value(nm1, 'NM103')
      n3 = nm1.next_element
      address_line_1, address_line_2 = address(n3) if n3.present?

      n4 = n3.next_element if n3.present?
      city, state, zip_code = city_state_zip(n4) if n4.present?
      list << {subscriber: {effective_date: dates.first, termination_date: dates.last, policy_number: policy_number,
               msp_code: insurance_type_code,
               option_code: mco_msg}, insurer: {name: insurance_name, address_line_1: address_line_1,
               address_line_2: address_line_2, city: city, state: state, zip_code: zip_code}}

    end
   list
  end

  def hcpcs_code_description(hcpcs_code)
    description = hcpcs_codes_list[hcpcs_code]
    description.present? ? "#{hcpcs_code}-#{description}" : hcpcs_code
  end

end