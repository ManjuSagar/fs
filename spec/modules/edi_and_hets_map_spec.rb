require 'spec_helper'

describe EDIAndHETSMap do
  require 'nokogiri'
  class EDIAndHETSMAPDummyClass < Netzke::Base
    include EDIAndHETSMap
  end

  subject {EDIAndHETSMAPDummyClass.new}
  let!(:xml) {File.read File.join("#{Rails.root}/static_data", 'ability.xml')}
  let!(:doc) {Nokogiri::XML(xml) do |config|
    config.options = Nokogiri::XML::ParseOptions::NOBLANKS
  end}

  it "should give xml as output when i give edi input" do
    dummy = EDIAndHETSMAPDummyClass.new

    edi_content = "ISA*00*          *00*          *ZZ*SUBMITTERID    *ZZ*CMS            *140516*0734*^*00501*000005014*0*P*|~
                   GS*HS*SUBMITTERID*CMS*20140831*073411*5014*X*005010X279A1~
                   ST*270*000000001*005010X279A1~
                   BHT*0022*13*TRANSA*20140831*073411~
                    EB*D**14*MB~DTP*356*D8*19230809~DTP*096*D8*19350809~
                    SE*186*0001~
                    GE*1*1~
                    IEA*1*111111111~"
    dummy.edi_2_xml(edi_content).should start_with('<?xml version="1.0" encoding="UTF-8"?><ediroot>')
  end

  it "should one 'Renal supplies in the home' and one 'Alternative method dialysis' ESRDs" do
    dummy = EDIAndHETSMAPDummyClass.new

    edi_content = "ISA*00*          *00*          *ZZ*CMS *ZZ*SUBMITTERID *140831*0758*^*00501*111111111*0*P*|~
                    GS*HB*CMS*SUBMITTERID*20140831*07580000*1*X*005010X279A1~
                    ST*271*0001*005010X279A1~
                    BHT*0022*11*TRANSA*20140831*07582355~
                    EB*D**14*MB~
                    DTP*356*D8*19230809~
                    DTP*096*D8*19350809~
                    EB*D**15*MB~
                    DTP*356*D8*19230810~
                    DTP*096*D8*19350810~
                    SE*9*0001~
                    GE*1*1~
                    IEA*1*111111111~"
    xml_content = dummy.edi_2_xml edi_content
    nokogiri = dummy.get_nokogiri_document xml_content
    esrds = dummy.esrd(nokogiri)
    res = esrds.size > 0
    res = (res and esrds[0][:esrd_code] == "14 - Renal Supplies in the Home")
    (res and esrds[1][:esrd_code] == "15 - Alternate Method Dialysis")
  end

  it "should return errors list" do
    dummy = EDIAndHETSMAPDummyClass.new
    edi_content = "ISA*00*          *00*          *ZZ*CMS            *ZZ*SUBMITTERID    *140610*0652*^*00501*147867930*0*P*|~
                  GS*HB*CMS*SUBMITTERID*20140610*06520000*1*X*005010X279A1~
                  ST*271*0001*005010X279A1~
                  BHT*0022*11*TRANSA*20140610*06522625~
                  HL*1**20*1~
                  NM1*PR*2*CMS*****PI*CMS~
                  PER*IC**UR*http://www.cms.gov/HETSHelp/*UR*http://www.cms.gov/center/provider.asp~
                  HL*2*1*21*1~
                  NM1*1P*2*Metropolitan Healthcare, Inc.*****XX*1942484381~
                  HL*3*2*22*0~TRN*2*TRACKNUM*ABCDEFGHIJ~
                  NM1*IL*1*ESTRINA*YELENA****MI*123900037M~AAA*N**72*C~
                  DMG*D8*19291018~
                  DTP*307*RD8*20120310-20141010~
                  SE*14*0001~
                  GE*1*1~
                  IEA*1*147867930~"

    xml_content = dummy.edi_2_xml edi_content
    nokogiri = dummy.get_nokogiri_document xml_content
    errors = dummy.error_code_display(nokogiri)
    res = errors.size > 0
    res and errors[0] == "72"
  end

  it "should return part A eligibility" do
    dummy = EDIAndHETSMAPDummyClass.new
    edi_content = "ISA*00*          *00*          *ZZ*CMS *ZZ*SUBMITTERID *140831*0758*^*00501*111111111*0*P*|~
                    GS*HB*CMS*SUBMITTERID*20140831*07580000*1*X*005010X279A1~
                    ST*271*0001*005010X279A1~
                    BHT*0022*11*TRANSA*20140831*07582355~
                    EB*1**30^42^45^48^49^69^76^83^A5^A7^AG^BT^BU^BV*MA~
                    DTP*291*RD8*19450202-19460202~
                    SE*5*0001~
                    GE*1*1~
                    IEA*1*111111111~"
    xml_content = dummy.edi_2_xml edi_content
    nokogiri = dummy.get_nokogiri_document xml_content
    part_a_eligibilities = dummy.part_a_eligibilities(nokogiri)
    res = part_a_eligibilities.size > 0
    res and part_a_eligibilities[:part_a_eligibility].present?
  end

  it "should return part B eligibility" do
    dummy = EDIAndHETSMAPDummyClass.new
    edi_content = "ISA*00*          *00*          *ZZ*CMS *ZZ*SUBMITTERID *140831*0758*^*00501*111111111*0*P*|~
                    GS*HB*CMS*SUBMITTERID*20140831*07580000*1*X*005010X279A1~
                    ST*271*0001*005010X279A1~
                    BHT*0022*11*TRANSA*20140831*07582355~
                    EB*1**30^2^3^23^24^25^26^27^28^33^36^37^38^39^40^42^50^51^52^53^67^69^73^76^83^86^98^A4^A6^A8^AI^AJ^"+
                          "AK^AL^BT^BU^BV^DM^UC*MB~
                    DTP*291*RD8*19450202-19460202~
                    SE*5*0001~
                    GE*1*1~
                    IEA*1*111111111~"
    xml_content = dummy.edi_2_xml edi_content
    nokogiri = dummy.get_nokogiri_document xml_content
    part_b_eligibilities = dummy.part_b_eligibilities(nokogiri)
    res = part_b_eligibilities.size > 0
    res and part_b_eligibilities[:part_b_eligibility].present?
  end

  it "should return both part A and part B eligibilities" do
    dummy = EDIAndHETSMAPDummyClass.new
    edi_content = "ISA*00*          *00*          *ZZ*CMS *ZZ*SUBMITTERID *140831*0758*^*00501*111111111*0*P*|~
                    GS*HB*CMS*SUBMITTERID*20140831*07580000*1*X*005010X279A1~
                    ST*271*0001*005010X279A1~
                    BHT*0022*11*TRANSA*20140831*07582355~
                    EB*1**30^42^45^48^49^69^76^83^A5^A7^AG^BT^BU^BV*MA~
                    DTP*291*RD8*19450202-19460202~
                    EB*1**30^2^3^23^24^25^26^27^28^33^36^37^38^39^40^42^50^51^52^53^67^69^73^76^83^86^98^A4^A6^A8^AI^AJ^"+
                          "AK^AL^BT^BU^BV^DM^UC*MB~
                    DTP*291*RD8*19450202-19460202~
                    SE*7*0001~
                    GE*1*1~
                    IEA*1*111111111~"
    xml_content = dummy.edi_2_xml edi_content
    nokogiri = dummy.get_nokogiri_document xml_content
    current_entitlement = dummy.current_entitlement(nokogiri)
    res = current_entitlement.size > 0
    res and current_entitlement[:part_a_eligibility].present? and current_entitlement[:part_b_eligibility].present?
  end

  it "should return part A eligibility effective date and termination date by sending type 'a' parameter" do
    dummy = EDIAndHETSMAPDummyClass.new
    edi_content = "ISA*00*          *00*          *ZZ*CMS *ZZ*SUBMITTERID *140831*0758*^*00501*111111111*0*P*|~
                    GS*HB*CMS*SUBMITTERID*20140831*07580000*1*X*005010X279A1~
                    ST*271*0001*005010X279A1~
                    BHT*0022*11*TRANSA*20140831*07582355~
                    EB*1**30^42^45^48^49^69^76^83^A5^A7^AG^BT^BU^BV*MA~
                    DTP*291*RD8*19450202-19460202~
                    SE*5*0001~
                    GE*1*1~
                    IEA*1*111111111~"
    xml_content = dummy.edi_2_xml edi_content
    nokogiri = dummy.get_nokogiri_document xml_content
    effective_date, termination_date = dummy.eligibility(nokogiri, 'a')
    effective_date.present?
  end

  it "should return part B eligibility effective date and termination date by sending type 'b' parameter" do
    dummy = EDIAndHETSMAPDummyClass.new
    edi_content = "ISA*00*          *00*          *ZZ*CMS *ZZ*SUBMITTERID *140831*0758*^*00501*111111111*0*P*|~
                    GS*HB*CMS*SUBMITTERID*20140831*07580000*1*X*005010X279A1~
                    ST*271*0001*005010X279A1~
                    BHT*0022*11*TRANSA*20140831*07582355~
                    EB*1**30^2^3^23^24^25^26^27^28^33^36^37^38^39^40^42^50^51^52^53^67^69^73^76^83^86^98^A4^A6^A8^AI^AJ^"+
        "AK^AL^BT^BU^BV^DM^UC*MB~
                    DTP*291*RD8*19450202-19460202~
                    SE*5*0001~
                    GE*1*1~
                    IEA*1*111111111~"
    xml_content = dummy.edi_2_xml edi_content
    nokogiri = dummy.get_nokogiri_document xml_content
    effective_date, termination_date = dummy.eligibility(nokogiri, 'b')
    effective_date.present?
  end

  it "should return part A deductibles" do
    dummy = EDIAndHETSMAPDummyClass.new
    edi_content = "ISA*00*          *00*          *ZZ*CMS *ZZ*SUBMITTERID *140831*0758*^*00501*111111111*0*P*|~
                    GS*HB*CMS*SUBMITTERID*20140831*07580000*1*X*005010X279A1~
                    ST*271*0001*005010X279A1~
                    BHT*0022*11*TRANSA*20140831*07582355~
                    EB*C**30*MA**26*1216~
                    DTP*291*RD8*20140101-20141231~
                    EB*C**30*MA**29*1216~
                    DTP*291*RD8*20140101-20141231~
                    EB*C**30*MA**26*1184~
                    DTP*291*RD8*20130101-20131231~
                    EB*C**30*MA**29*1184~
                    DTP*291*RD8*20130101-20131231~
                    EB*C**30*MA**29*0~
                    DTP*291*RD8*20130101-20130106~
                    EB*C**42^45*MA**26*0~
                    DTP*292*RD8*20140101-20141231~
                    EB*C**42^45*MA**26*0~
                    DTP*292*RD8*20130101-20131231~
                    SE*17*0001~
                    GE*1*1~
                    IEA*1*111111111~"

    xml_content = dummy.edi_2_xml edi_content
    nokogiri = dummy.get_nokogiri_document xml_content
    part_a_deductibles = dummy.part_a_deductibles(nokogiri)
  end


  it "Beneficary information should not be empty" do
    beneficiary_information = subject.beneficiary_information(doc, "Metro")
    expect(beneficiary_information[:beneficiary].values.compact).not_to be_empty
  end

  it "should return Part A eligibility passing through xml" do
    part_a_eligibilities = subject.part_a_eligibilities(doc)
    expect(part_a_eligibilities[:part_a_eligibility].values.compact).not_to be_empty
  end

  it "should return Part B eligibility passing through xml" do
    part_b_eligibilities = subject.part_b_eligibilities(doc)
    expect(part_b_eligibilities[:part_b_eligibility].values.compact).not_to be_empty
  end

  it "Part A inactive periods should be empty" do
    inactive_periods = subject.part_a_inactive_periods(doc)
    expect(inactive_periods).to be_empty
  end

  it "Part B inactive periods should be empty" do
    inactive_periods = subject.part_b_inactive_periods(doc)
    expect(inactive_periods).to be_empty
  end

  it "End stage renal diagnosis should be empty" do
    esrd = subject.esrd(doc)
    expect(esrd).to be_empty
  end

  it "Part A deductables should not be empty" do
    part_a_deductibles = subject.part_a_deductibles(doc)
    expect(part_a_deductibles).not_to be_empty
  end

  it "Part B deductables should not be empty" do
    part_b_deductibles = subject.part_b_deductibles(doc)
    expect(part_b_deductibles).not_to be_empty
  end

  it "Co insurance details should not be empty" do
    co_insurance_details = subject.co_insurance_details(doc)
    expect(co_insurance_details.collect{|x| x.values}.compact).not_to be_empty
  end

  it "Blood deductibles should not be empty" do
    blood_deductibles = subject.blood_deductibles(doc)
    expect(blood_deductibles.collect{|x| x.values.compact}).not_to be_empty
  end

  it "Occupational theraphy cap should be empty" do
    occupational_theraphy_caps = subject.occupational_theraphy_cap(doc)
    expect(occupational_theraphy_caps.each{|x| x.values.compact}).to be_empty
  end

  it "Physical and speech therapy cap should not be empty" do
    physical_and_speech_therapy_caps = subject.physical_and_speech_theraphy_cap(doc)
    expect(physical_and_speech_therapy_caps.collect{|x| x.values.compact}).not_to be_empty
  end

  it "Pulomonary rehabilitation should not be empty" do
    pulamonary_rehabilitations = subject.pulmonary_rehabilitation(doc)
    expect(pulamonary_rehabilitations.values).not_to be_empty
  end

  it "Pulomonary rehabilitation should not be empty" do
    pulamonary_rehabilitations = subject.pulmonary_rehabilitation(doc)
    expect(pulamonary_rehabilitations.values).not_to be_empty
  end

  it "Cardiac rehabilitation should not be empty" do
    cardiac_rehabilitations = subject.cardiac_rehabilitation(doc)
    expect(cardiac_rehabilitations.values).not_to be_empty
  end

  it "Preventives should not be empty" do
    preventives = subject.preventives(doc)
    expect(preventives[:preventive_services].collect{|x| x.values.compact}).not_to be_empty
  end

  it "Smoking cessation should not be empty" do
    smoking_cessions = subject.smoking_cessions(doc)
    expect(smoking_cessions[:counselling_periods].collect{|x| x.values.compact}).not_to be_empty
  end

  it "Plan coverage should not be empty" do
    plan_coverage = subject.plan_coverage(doc)
    expect(plan_coverage).not_to be_empty
  end

  it "Medicare Secondary payers should be empty" do
    msp = subject.medicare_secondary_payers(doc)
    expect(msp).to be_empty
  end

  it "Hospice information should be empty" do
    hospice = subject.hospice_information(doc)
    expect(hospice).to be_empty
  end

  it "Home health care should not be empty" do
    subject.stub(:home_health_and_hospice).and_return(["X"])
    subject.stub(:get_provider_name).and_return("Metro home health")
    home_health_care = subject.home_health_care(doc)
    expect(home_health_care[:home_health_episodes].collect{|x| x.values.compact}).not_to be_empty
  end


  it "Home health certifications should not be empty"  do
    home_health_certs = subject.home_health_certifications(doc)
    expect(home_health_certs[:home_health_certifications]).not_to be_empty
  end

  it "Home health recertifications should not be empty" do
    home_health_recerts = subject.home_health_re_certifications(doc)
    expect(home_health_recerts[:home_health_recertifications]).not_to be_empty
  end

  it "Inpatient hospital details should not be empty" do
    inpatient_details = subject.inpatient_spell(doc, ["30"])
    expect(inpatient_details).not_to be_empty
  end

  it "Inpatient skilled nursing facilities should not be empty" do
    snf_details = subject.inpatient_spell(doc, ["AG"])
    expect(snf_details).not_to be_empty
  end

  it "Life time reserved days should not be empty" do
    reserved_days = subject.life_time_reserve_days(doc)
    expect(reserved_days[:life_time_reserve_days_details]).not_to be_empty
  end

  it "Psychiatric limitation days should not be empty" do
    limitation_days =  subject.psychiatric_limitation_days(doc)
    expect(limitation_days[:pshychiatric_limitation_days_details]).not_to be_empty
  end

end

