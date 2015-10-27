require 'spec_helper'

describe UnverifiedMedicationsReportDataSource do

  before(:each) do
    Org.current = Org.find_by_email("info@mymetrohc.com")
  end

  it "unverified medications list should not be empty" do
    medication = UnverifiedMedicationsReportDataSource.new ({})
    medication.empty?.should_not be_true
  end

  it "should return allergies" do
    med = UnverifiedMedicationsReportDataSource.new({})
    treatment_medication = FactoryGirl.build(:treatment_medication)
    treatment_medication.stub(:allergies).and_return("ASPIRIN")
    med.allergies(treatment_medication).should == "ASPIRIN"
  end

  it "should return medication purpose" do
    med = UnverifiedMedicationsReportDataSource.new({})
    treatment_medication = FactoryGirl.build(:treatment_medication)
    med.medication_reason(treatment_medication).should == treatment_medication.purpose
  end

  it "should return medication reporter name" do
    med = UnverifiedMedicationsReportDataSource.new({})
    treatment_medication = FactoryGirl.build(:treatment_medication)
    staff = treatment_medication.created_user
    staff_name = staff.full_name
    staff_name += " #{staff.phone_number}" unless staff.phone_number.blank?
    med.get_reporter_name(treatment_medication).should == staff_name
  end

end