require 'spec_helper'

describe TreatmentRequest do

  let!(:treatment_request) {FactoryGirl.build(:treatment_request)}
  subject {treatment_request}

  it "should return true if staffed , referral received and not discharged" do
    subject.stub(:staffed?).and_return(true)
    subject.stub(:referral_received?).and_return(true)
    subject.stub(:no_undischarged_treatment?).and_return(true)
    subject.should be_staffed_and_referral_received_and_no_undischarged_treatment
  end

  it "should return true if eligibility check completed" do
    treatment_request = FactoryGirl.build(:treatment_request, :eligibility_check_flag => true)
    treatment_request.eligibility_check_completed?.should be_true
  end

  it "should return true if attached referral is nil or referral received" do
    subject.stub(:attached_referral).and_return(nil)
    subject.stub(:referral_received_flag).and_return(true)
    subject.should be_referral_received
  end

  it "should return empty discipline list" do
    subject.stub(:disciplines_list).and_return([])
    subject.disciplines_list.should be_empty
  end

  it "should return empty visit types list" do
    subject.stub(:visit_types_list).and_return([])
    subject.visit_types_list.should be_empty
  end

  it "should return referral attachment " do
    referral_attachment = FactoryGirl.build(:treatment_request_attachment)
    subject.stub(:attached_referral).and_return([referral_attachment])
    subject.attached_referral.should == [referral_attachment]
  end

  it "should return patient insurance company" do
    subject.stub(:patient_insurance_companies).and_return("Medicare Health Insurance")
    subject.patient_insurance_companies == "Medicare Health Insurance"
  end

  it "should return referral staffs" do
    field_staff = FactoryGirl.build(:field_staff)
    staffs = subject.stub(:get_staffs)
    subject.stub(:staffs_for_referral).and_return([field_staff])
    subject.staffs_for_referral({:request_staff_id => TreatmentRequestStaff.first.id}) == [field_staff]
  end
end
