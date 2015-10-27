require 'spec_helper'

describe TreatmentVisit do
  let!(:treatment_visit){FactoryGirl.build(:treatment_visit)}
  subject {treatment_visit}

  it 'should raise error if staffing company has expired' do
    treatment_visit.stub(:contract_period_with_in_from_date_and_to_date).with(Date.new(2014,04,15)).and_return([])
    treatment_visit.valid?
    subject.errors[:base].should include("We are unable to post this visit because the Staffing Company contract has expired.
                        Please renew or extend the contract in the Staffing Company profile to allow visit posting.")
  end

  it "should return Staffing Company Contract if contract period is not expired." do
    staffing_company_contract = FactoryGirl.build(:staffing_company_contract)
    treatment_visit.visited_staff = FactoryGirl.build(:staffing_company)
    treatment_visit.stub(:visited_user)
    treatment_visit.visited_staff.stub(:agency_contracts)
    treatment_visit.visited_staff.stub(:contract_period_with_in_from_date_and_to_date).and_return(staffing_company_contract)
    treatment_visit.valid?
    treatment_visit.errors[:base].should_not include("We are unable to post this visit because the Staffing Company contract has expired.
                        Please renew or extend the contract in the Staffing Company profile to allow visit posting.")
  end

  it "should raise an error when time in/ time out includes ':' in visits batch entry" do
    treatment_visit.raise_time_format_error('12:34', 'Time In')
    treatment_visit.errors[:base].should include("Time In should be in 'HHMM' format")
  end

  it "should not raise errors when time in/ time out not include ':' in visits batch entry" do
    treatment_visit.start_time = "1234"
    treatment_visit.end_time = "2345"
    treatment_visit.schedule_visit_time_in_and_time_out_format_check
    treatment_visit.errors[:base].should_not include("Time In should be in 'HHMM' format")
  end

  it "should be editable" do
    visit = FactoryGirl.build(:treatment_visit, draft_status: true)
    visit.should be_editable
  end

  it "should be deleteable" do
    treatment_visit.stub(:payables)
    treatment_visit.payables.stub(:paid_payables).and_return([])
    treatment_visit.stub(:documents).and_return([])
    treatment_visit.can_delete?.should == true
  end

  it "draft status is true" do
    visit = FactoryGirl.build(:treatment_visit, draft_status: true)
    visit.draft_status_changed?.should == true
  end

  it "should set visited staff to current login field staff" do
    User.current = FactoryGirl.build(:field_staff)
    visit = FactoryGirl.build(:treatment_visit)
    visit.set_draft_status_visit_details
    visit.visited_staff.should equal(User.current)
  end

  it "should set visited user to current login field staff" do
    User.current = FactoryGirl.build(:field_staff)
    visit = FactoryGirl.build(:treatment_visit)
    visit.set_draft_status_visit_details
    visit.visited_user.should equal(User.current)
  end

end