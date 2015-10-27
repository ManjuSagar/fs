require 'spec_helper'

 describe 'private_receivable' do

   before(:each) do
     @private_receivables = FactoryGirl.build(:private_receivable, receivable_status: :draft)
   end

   it "should have the self table name as receivables" do
     @private_receivables.class.table_name.should == "receivables"
   end

   it "should initially must be in draft status" do
     @private_receivables.receivable_status.should == :draft
   end

   it "should return true for fresh receivables for the method may_mark_as_sent?" do
     @private_receivables.stub(:system_driven_event).and_return(true)
     @private_receivables.may_mark_as_sent?.should == true
   end

   it "should return true for receivables in sent status for the method may_undo?" do
     @private_receivables.stub(:system_driven_event).and_return(true)
     @private_receivables.mark_as_sent
     @private_receivables.stub(:remove_from_invoice).and_return(true)
     @private_receivables.stub(:check_receivable_is_in_sent?).and_return(true)
     @private_receivables.may_undo?.should == true
   end

   it "should change from draft to sent status" do
     @private_receivables.stub(:system_driven_event).and_return(true)
     expect {@private_receivables.mark_as_sent}.to change {@private_receivables.receivable_status}. from(:draft).to(:sent)
   end

   it "should change from sent to draft on undo" do
     @private_receivables.stub(:system_driven_event).and_return(true)
     @private_receivables.mark_as_sent
     @private_receivables.stub(:remove_from_invoice).and_return(true)
     @private_receivables.stub(:check_receivable_is_in_sent?).and_return(true)
     expect {@private_receivables.undo}.to change {@private_receivables.receivable_status}. from(:sent).to(:draft)
   end

   it "should change from received to sent on undo" do
     @private_receivables.stub(:system_driven_event).and_return(true)
     @private_receivables.mark_as_sent
     @private_receivables.stub(:remove_from_invoice).and_return(true)
     @private_receivables.stub(:check_receivable_is_in_received?).and_return(true)
     expect {@private_receivables.undo}.to change {@private_receivables.receivable_status}. from(:sent).to(:draft)
   end

   it "should change from sent to received on mark_as_received" do
     @private_receivables.stub(:system_driven_event).and_return(true)
     @private_receivables.mark_as_sent
     expect {@private_receivables.mark_as_received}.to change {@private_receivables.receivable_status}. from(:sent).to(:received)
   end

   it "should return false for the method check_receivable_is_in_sent? for the receivable in draft status" do
     @private_receivables.check_receivable_is_in_sent?.should == false
   end

   it "should return true for the method check_receivable_is_in_sent? for the receivable in sent status" do
     @private_receivables.stub(:system_driven_event).and_return(true)
     @private_receivables.mark_as_sent
     @private_receivables.check_receivable_is_in_sent?.should == true
   end

   it "should return false for the method check_receivable_is_in_received? for the receivable in draft status" do
     @private_receivables.check_receivable_is_in_received?.should == false
   end

   it "should return false for the method check_receivable_is_in_received? for the receivable in sent status" do
     @private_receivables.stub(:system_driven_event).and_return(true)
     @private_receivables.mark_as_sent
     @private_receivables.check_receivable_is_in_received?.should == false
   end

   it "should return true for the method check_receivable_is_in_received? for the receivable in sent status" do
     @private_receivables.stub(:system_driven_event).and_return(true)
     @private_receivables.mark_as_sent
     @private_receivables.mark_as_received
     @private_receivables.check_receivable_is_in_received?.should == true
   end

 end

