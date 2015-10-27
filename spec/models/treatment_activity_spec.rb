require 'spec_helper'
describe TreatmentActivity do

 let!(:treatment_activity){FactoryGirl.build(:treatment_activity)}
 subject {:treatment_activity}

  it "validate the activity reason code" do
    treatment_activity.activity_reason_code.should_not be_nil
  end

 it "validate the activity date" do
   treatment_activity.activity_date.should_not be_nil
 end

 it "validate activity date should be within the date range" do
   activity = FactoryGirl.build(:treatment_activity, :activity_date => Date.today)
   episode_start_date = Date.yesterday
   episode_end_date = Date.today + 60

   activity.activity_date.should be_between(episode_start_date, episode_end_date)
 end

end

describe "hold and unhold" do
  it "should create a record in all documents when there is hold option with discipline id " do
    document = FactoryGirl.build(:all_document,status: 'HOLD-ON')
    document.status == 'HOLD-ON'
  end

  it "should create a record in all documents when there is unhold option with discipline id " do
    document = FactoryGirl.build(:all_document, status: 'HOLD_OFF')
    document.status == 'HOLD_OFF'
  end

  it "should create a record in all documents when there is hold  without discipline id" do
    document = FactoryGirl.build(:all_document, status: 'HOLD_ON', staff: "All Discipline")
    document.status == 'HOLD-ON'
    document.staff == 'All Discipline'
  end

  it "should create a record in all documents when there is hold  without discipline id" do
    document = FactoryGirl.build(:all_document, status: 'HOLD_OFF', staff: "All Discipline")
    document.status == 'HOLD_OFF'
    document.staff == 'All Discipline'
  end
 end

