require 'spec_helper'

describe StaffingRequest do

  let!(:staffing_request) {FactoryGirl.build(:staffing_request)}
  subject {staffing_request}

  it "Active filter should include 'new', 'declined', 'interested'" do
    StaffingRequest::ACTIVE.should be_include(StaffingRequest::STATE_MAP[:new])
    StaffingRequest::ACTIVE.should be_include(StaffingRequest::STATE_MAP[:declined])
    StaffingRequest::ACTIVE.should be_include(StaffingRequest::STATE_MAP[:interested])
  end

  it "Archive filter should include 'selected', 'cancelled'" do
    StaffingRequest::ARCHIVE.should be_include(StaffingRequest::STATE_MAP[:selected])
    StaffingRequest::ARCHIVE.should be_include(StaffingRequest::STATE_MAP[:cancelled])
  end

  it "should return true if staff is not finalized" do
    subject.should be_staff_not_finalized
  end

  it "should return true if staff is finalized" do
    subject.staff_finalized = true
    subject.should be_staff_finalized
  end

  it "should be true office staff login and staff is not finalized" do
    subject.stub(:current_user_is_office_staff?).and_return(true)
    subject.stub(:staff_not_finalized?).and_return(true)
    subject.should be_current_user_is_office_staff_and_staff_not_finalized
  end

  it "should be true office staff login and staff is not finalized and previous status is 'new'" do
    subject.stub(:current_user_is_office_staff_and_staff_not_finalized?).and_return(true)
    subject.stub(:previous_status_is_new?).and_return(true)
    subject.should be_current_user_is_office_staff_and_previous_status_is_new_and_staff_not_finalized
  end

  it "should be true office staff login and staff is not finalized and previous status is 'expressed interest'" do
    subject.stub(:current_user_is_office_staff_and_staff_not_finalized?).and_return(true)
    subject.stub(:previous_status_is_interested?).and_return(true)
    subject.should be_current_user_is_office_staff_and_previous_status_is_interested_and_staff_not_finalized
  end

  it "should be true office staff login and staff is not finalized and previous status is 'selected'" do
    subject.stub(:current_user_is_office_staff_and_staff_not_finalized?).and_return(true)
    subject.stub(:previous_status_is_selected?).and_return(true)
    subject.should be_current_user_is_office_staff_and_previous_status_is_selected_and_staff_not_finalized
  end

  it "should be true office staff login and staff is not finalized and previous status is 'declined'" do
    subject.stub(:current_user_is_office_staff_and_staff_not_finalized?).and_return(true)
    subject.stub(:previous_status_is_declined?).and_return(true)
    subject.should be_current_user_is_office_staff_and_previous_status_is_declined_and_staff_not_finalized
  end

  it "should be true when previous status is 'new'" do
    subject.previous_request_status = :new
    subject.should be_previous_status_is_new
  end

  it "should be true when previous status is 'expressed interest'" do
    subject.previous_request_status = :interested
    subject.should be_previous_status_is_interested
  end

  it "should be true when previous status is 'selected'" do
    subject.previous_request_status = :selected
    subject.should be_previous_status_is_selected
  end

  it "should be true when previous status is 'declined'" do
    subject.previous_request_status = :declined
    subject.should be_previous_status_is_declined
  end

end
