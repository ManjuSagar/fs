require 'spec_helper'

describe "Patient" do

  class TestClass
    def self.guru
      true
    end
  end

  before(:each) do
    PatientReferenceNumber.stub(:ref_record) { rand(1000000) } #(Org.current.id, "PatientReferenceNumber")
  end

  it 'test test' do
    TestClass.guru.should be_true
  end

  Org.current =  FactoryGirl.build(:patient, first_name: 'a'*101).org # Org.find(145)

  it 'is invalid without the field First Name' do
    patient = FactoryGirl.build(:patient, first_name: nil)
    patient.stub(:patient_detail)
    patient.patient_detail.stub(:valid?).and_return(true)
    patient.patient_detail.stub(:check_patient_reference_uniqness).and_return(nil)
    patient.should_not be_valid
  end

  it 'is invalid without the field Last Name' do
    patient = FactoryGirl.build(:patient, last_name: nil)
    patient.stub(:patient_detail)
    patient.patient_detail.stub(:valid?).and_return(true)
    patient.patient_detail.stub(:check_patient_reference_uniqness).and_return(nil)
    patient.should_not be_valid
  end

  it 'is invalid without the field DOB' do
    patient = FactoryGirl.build(:patient, dob: nil)
    patient.stub(:patient_detail)
    patient.patient_detail.stub(:valid?).and_return(true)
    patient.patient_detail.stub(:check_patient_reference_uniqness).and_return(nil)
    patient.should_not be_valid
  end

  it 'is invalid without the field Gender' do
    patient = FactoryGirl.build(:patient, gender: nil)
    patient.stub(:patient_detail)
    patient.patient_detail.stub(:valid?).and_return(true)
    patient.patient_detail.stub(:check_patient_reference_uniqness).and_return(nil)
    patient.should_not be_valid
  end

  it 'is invalid without the field Zip Code' do
    patient = FactoryGirl.build(:patient, zip_code: nil)
    patient.stub(:patient_detail)
    patient.patient_detail.stub(:valid?).and_return(true)
    patient.patient_detail.stub(:check_patient_reference_uniqness).and_return(nil)
    patient.should_not be_valid
  end

  it 'is invalid without the field SSN' do
    patient = FactoryGirl.build(:patient, ssn: nil)
    patient.stub(:patient_detail)
    patient.patient_detail.stub(:valid?).and_return(true)
    patient.patient_detail.stub(:check_patient_reference_uniqness).and_return(nil)
    patient.should_not be_valid
  end

  it 'is invalid without the field Medicare Number' do
    patient = FactoryGirl.build(:patient, medicare_number: nil)
    patient.stub(:patient_detail)
    patient.patient_detail.stub(:valid?).and_return(true)
    patient.patient_detail.stub(:check_patient_reference_uniqness).and_return(nil)
    patient.should_not be_valid
  end

  it 'is invalid when a first_name has more than 100 characters' do
    patient = FactoryGirl.build(:patient, first_name: 'a'*101)
    patient.stub(:patient_detail)
    patient.patient_detail.stub(:valid?).and_return(true)
    patient.patient_detail.stub(:check_patient_reference_uniqness).and_return(nil)
    patient.should_not be_valid
  end

  it 'is invalid when a last_name has more than 100 characters' do
    patient = FactoryGirl.build(:patient, last_name: 'a'*101)
    patient.stub(:patient_detail)
    patient.patient_detail.stub(:valid?).and_return(true)
    patient.patient_detail.stub(:check_patient_reference_uniqness).and_return(nil)
    patient.should_not be_valid
  end

  it 'is invalid when zip_code length exceeds 5 digit' do
    FactoryGirl.build(:patient, zip_code: '90013').zip_code.length.should <= 5
  end

  it 'is invalid without Zip Code in the address' do
    patient = FactoryGirl.build(:patient, zip_code: nil)
    patient.stub(:patient_detail)
    patient.patient_detail.stub(:valid?).and_return(true)
    patient.patient_detail.stub(:check_patient_reference_uniqness).and_return(nil)
    patient.should_not be_valid
  end

 it 'is invalid without gender' do
   patient = FactoryGirl.build(:patient, gender: nil)
   patient.stub(:patient_detail)
   patient.patient_detail.stub(:valid?).and_return(true)
   patient.patient_detail.stub(:check_patient_reference_uniqness).and_return(nil)
   patient.should_not be_valid
 end

 it 'zip code should not valid' do
   patient = FactoryGirl.build(:patient, zip_code: "0000")
   patient.valid_zip_code_check.include?(" is not valid.").should be_true
 end

  it 'zip code should be valid' do
    patient = FactoryGirl.build(:patient, zip_code: "90013")
    patient.valid_zip_code_check.should be_nil
  end

  it 'ssn number length should not be greater than 11' do
     FactoryGirl.build(:patient, ssn: "123456789").ssn.length.should <= 11
  end

  it 'is invalid if street_address is having more than 50 characters' do
    FactoryGirl.build(:patient, street_address: "101MS" * 10).street_address.length.should <= 50
  end

  it 'is invalid if suite_number has more than 10 characters' do
    FactoryGirl.build(:patient, suite_number: "9283989889").suite_number.length.should <= 10
  end

  it 'is invalid if city is having more than 50 characters' do
    FactoryGirl.build(:patient, city: 'b' * 50).city.length.should <= 50
  end

  it 'should have atleast one phone number' do
    patient = FactoryGirl.build(:patient, phone_number: '(986) 899-7889', phone_number_2: '(878) 678-8898')
    patient.should have_at_least(1).phone_numbers
  end

  it 'should have Primary Insurance Company' do
    patient = FactoryGirl.build(:patient)
    patient.stub(:active_treatment)
    patient.stub(:treatment_request)
    patient.stub(:insurance_company)
    patient.stub(:primary_insurance_company)
    patient.primary_insurance_company.stub(:company_name).and_return("Medicare Insurance Company")
    #res1 = patient.stub(:primary_insurance_company_name).and_return("Medicare Insurance Company")
    #debug_log "res.................#{res.inspect}.......res1..........#{res1}"
    #res = patient.stub(:primary_insurance_company_name).and_return("Medicare Insurance Company")
    patient.stub(:primary_insurance_company_name).and_return("Medicare Insurance Company")
    patient.primary_insurance_company_name.should == "Medicare Insurance Company"
  end

  it "Date of Birth should be equal to 02/05/1975" do
    patient = FactoryGirl.build(:patient)
    patient.dob.strftime("%m/%d/%Y").should == "02/05/1975"
  end

end