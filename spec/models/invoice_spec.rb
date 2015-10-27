require 'spec_helper'

describe Invoice do
  let(:oasis){mock_model(OasisEvaluation, :m1100_ptnt_lvg_stutn => "02")}

  it "Invoice type should not be RAP" do
    invoice = FactoryGirl.build(:invoice)
    invoice.invoice_type.should_not == "322"
  end

  it "should return true if claim is final claim" do
    invoice = FactoryGirl.build(:invoice, invoice_type: '329')
    invoice.should be_final_claim
  end

  it "transferred from another hha invoice condition code should be 47" do
    invoice = FactoryGirl.build(:invoice)
    invoice.stub(:treatment)
    invoice.treatment.stub(:treatment_request)
    invoice.treatment.treatment_request.stub(:transfer_from_hha).and_return("Y")
    invoice.transfer_from_hha.should == "47"
  end

  context "RAP Hipps code update" do
    let(:invoice) { FactoryGirl.build(:invoice, invoice_type: '322')}

    subject { invoice }
    it "should return true if RAP claim is in draft" do
      subject.should be_can_update_hipps_code_and_amount
    end

    it "should return false if RAP claim is in approved" do
      subject.invoice_status = :approved
      subject.should_not be_can_update_hipps_code_and_amount
    end

    it "should return home health service receivable" do
      subject.receivables.build({purpose: "Home Health Services"})
      subject.receivables.build({purpose: "ABC"})
      subject.home_health_service.purpose.should == "Home Health Services"
    end

    it "should update invoice amount and receivable hipps code and amount" do
=begin
      invoice = FactoryGirl.create(:invoice, invoice_type: '322')
      invoice.receivables << FactoryGirl.build(:receivable, purpose: 'Home Health Services')
      invoice.save!
      rec = invoice.home_health_service
      invoice.update_hipps_code_and_amount({hipps_code: "1CFKS", amount: 4321.65})
      rec.receivable_amount.should == invoice.invoice_amount
=end
    end
  end

   #event approve

    context "Change invoice Status, invoice date and " do
    it "should be approved" do
      invoice = FactoryGirl.build(:invoice, :invoice_status => :draft)
      Org.current = FactoryGirl.build(:health_agency)
      invoice.stub(:update_status_date).and_return(true)
      expect { invoice.approve}.to change {invoice.invoice_status}.from(:draft).to(:approved)
    end

    xit "should  save the approved date " do
      invoice = FactoryGirl.build(:invoice, :invoice_status=> :draft)
      Org.current = FactoryGirl.build(:health_agency)
      invoice.stub(:update_status_date).and_return(true)
      expect { invoice.approve}.to change {invoice.approved_date}.from(nil).to(Date.current.strftime("%m/%d/%Y"))
    end

    xit "should save the status date on approve " do
      invoice = FactoryGirl.build(:invoice, :invoice_status=> :draft)
      Org.current = FactoryGirl.build(:health_agency)
      invoice.stub(:update_status_date).and_return(true)
      expect { invoice.approve}.to change {invoice.status_date}.from(nil).to(Date.current)
    end

    # event mark_as_sent

    it "should be sent" do
      invoice = FactoryGirl.build(:invoice, :invoice_status => :approved)
      Org.current = FactoryGirl.build(:health_agency)
      invoice.stub(:update_status_date).and_return(true)
      invoice.stub(:current_user_is_consultant_or_ha_not_associated_with_consultant?).and_return(true)
      invoice.sent_date = Date.current
      expect { invoice.mark_as_sent}.to change {invoice.invoice_status}.from(:approved).to(:sent)
    end

    xit "should save the sent date " do
      invoice = FactoryGirl.build(:invoice, :invoice_status=> :draft)
      invoice.approve
      invoice.stub(:current_user_is_consultant_or_ha_not_associated_with_consultant?).and_return(true)
      invoice.sent_date = Date.current
      expect { invoice.mark_as_sent}.to change {invoice.invoice_sent_date}.from(nil).to(Date.current.strftime("%m/%d/%Y"))
    end


    xit "should save the status date on Send " do
      invoice = FactoryGirl.build(:invoice, :invoice_status=> :draft)
      invoice.approve
      invoice.stub(:current_user_is_consultant_or_ha_not_associated_with_consultant?).and_return(true)
      invoice.sent_date = Date.current + 1
      expect { invoice.mark_as_sent}.to change {invoice.status_date.strftime("%Y-%d-%m")}.from(invoice.approved_date.to_date.strftime("%Y-%m-%d")).to(invoice.sent_date.strftime("%Y-%d-%m"))
    end

    #event pay

    it "should be paid " do
      invoice = FactoryGirl.build(:invoice, :invoice_status=> :sent, :invoice_type=> "322")
      invoice.stub(:all_items_are_paid_and_system_driven_event?).and_return(true)
      Org.current = FactoryGirl.build(:health_agency)
      invoice.stub(:update_status_date).and_return(true)
      expect { invoice.pay}.to change {invoice.invoice_status}.from(:sent).to(:paid)
    end

    xit "should be paid and save the paid date" do
      invoice = FactoryGirl.build(:invoice, :invoice_status=> :sent, :invoice_type=> "322")
      invoice.stub(:all_items_are_paid_and_system_driven_event?).and_return(true)
      invoice.sent_date = Date.current + 1
      expect {invoice.pay}.to change {invoice.paid_date}.from(nil).to(Date.current.strftime("%m/%d/%Y"))
    end

    xit "should be paid and update the invoice status date"do
      invoice = FactoryGirl.build(:invoice, :invoice_status=> :sent, :invoice_type=> "322")
      invoice.stub(:all_items_are_paid_and_system_driven_event?).and_return(true)
      invoice.pay
      invoice.status_date.strftime("%Y-%m-%d").should == invoice.paid_date.to_date.strftime("%Y-%d-%m")
      #expect to change {invoice.status_date.strftime("%Y-%d-%m")}.from(invoice.sent_date.to_date.strftime("%Y-%m-%d")).to(invoice.paid_date.strftime("%Y-%d-%m"))
    end

    it "should be partially paid " do
      invoice = FactoryGirl.build(:invoice, :invoice_status=> :sent, :invoice_type=> "322")
      invoice.stub(:not_all_items_are_paid_and_system_driven_event?).and_return(true)
      Org.current = FactoryGirl.build(:health_agency)
      invoice.stub(:update_status_date).and_return(true)
      expect { invoice.pay}.to change {invoice.invoice_status}.from(:sent).to(:partially_paid)
    end

    xit "should be partially paid and save the partially paid date" do
      invoice = FactoryGirl.build(:invoice, :invoice_status=> :sent, :invoice_type=> "322")
      invoice.stub(:not_all_items_are_paid_and_system_driven_event?).and_return(true)
      expect {invoice.pay}.to change {invoice.partially_paid_date}.from(nil).to(Date.current.strftime("%m/%d/%Y"))
    end

    xit "should be partially paid and update the invoice status date"do
      invoice = FactoryGirl.build(:invoice, :invoice_status=> :sent, :invoice_type=> "322")
      invoice.stub(:not_all_items_are_paid_and_system_driven_event?).and_return(true)
      invoice.pay
      invoice.status_date.strftime("%Y-%m-%d").should == invoice.partially_paid_date.to_date.strftime("%Y-%d-%m")
    end


    it "should be paid from  partially paid " do
      invoice = FactoryGirl.build(:invoice, :invoice_status=> :partially_paid, :invoice_type=> "322")
      invoice.stub(:all_items_are_paid_and_system_driven_event?).and_return(true)
      Org.current = FactoryGirl.build(:health_agency)
      invoice.stub(:update_status_date).and_return(true)
      expect { invoice.pay}.to change {invoice.invoice_status}.from(:partially_paid).to(:paid)
    end

    xit "should be paid from  partially paid and save the paid date" do
      invoice = FactoryGirl.build(:invoice, :invoice_status=> :partially_paid, :invoice_type=> "322")
      invoice.stub(:all_items_are_paid_and_system_driven_event?).and_return(true)
      expect {invoice.pay}.to change {invoice.paid_date}.from(nil).to(Date.current.strftime("%m/%d/%Y"))
    end

    xit "should be paid and from  partially paid and update the invoice status date"do
      invoice = FactoryGirl.build(:invoice, :invoice_status=> :sent, :invoice_type=> "322")
      invoice.stub(:not_all_items_are_paid_and_system_driven_event?).and_return(true)
      invoice.pay
      invoice.status_date.strftime("%Y-%m-%d").should == invoice.paid_date.to_date.strftime("%Y-%d-%m")
    end

    it "should be partially paid from partially paid " do
        invoice = FactoryGirl.build(:invoice, :invoice_status=> :partially_paid, :invoice_type=> "322")
        invoice.stub(:not_all_items_are_paid_and_system_driven_event?).and_return(true)
        Org.current = FactoryGirl.build(:health_agency)
        invoice.stub(:update_status_date).and_return(true)
        expect { invoice.pay}.not_to change {invoice.invoice_status}.from(:partially_paid).to(:sent)
    end

    #event undo

      it "Should return to the sent status from paid" do
        invoice = FactoryGirl.build(:invoice, :invoice_status=> :paid, :invoice_type=> "322")
        invoice.stub(:all_items_are_not_paid_and_system_driven_event?).and_return(true)
        Org.current = FactoryGirl.build(:health_agency)
        invoice.stub(:update_status_date_for_undo).and_return(true)
        expect { invoice.undo}.to change {invoice.invoice_status}.from(:paid).to(:sent)
      end

    it "Should return to the sent status from partially paid" do
      invoice = FactoryGirl.build(:invoice, :invoice_status=> :partially_paid, :invoice_type=> "322")
      invoice.stub(:all_items_are_not_paid_and_system_driven_event?).and_return(true)
      Org.current = FactoryGirl.build(:health_agency)
      invoice.stub(:update_status_date_for_undo).and_return(true)
      expect { invoice.undo}.to change {invoice.invoice_status}.from(:partially_paid).to(:sent)
    end

    it "Should return to the approved status from draft" do
      invoice = FactoryGirl.build(:invoice, :invoice_status=> :approved, :invoice_type=> "322")
      invoice.stub(:current_user_is_office_staff?).and_return(true)
      Org.current = FactoryGirl.build(:health_agency)
      invoice.stub(:update_status_date_for_undo).and_return(true)
      expect { invoice.undo}.to change {invoice.invoice_status}.from(:approved).to(:draft)
    end

    it "Should return to the approved status from sent" do
      invoice = FactoryGirl.build(:invoice, :invoice_status=> :sent, :invoice_type=> "322")
      invoice.stub(:current_user_is_consultant_or_ha_not_associated_with_consultant?).and_return(true)
      Org.current = FactoryGirl.build(:health_agency)
      invoice.stub(:update_status_date_for_undo).and_return(true)
      expect { invoice.undo}.to change {invoice.invoice_status}.from(:sent).to(:approved)
    end

    #event mark_as_denied

    it "Should mark as denied from paid" do
      invoice = FactoryGirl.build(:invoice, :invoice_status=> :paid, :invoice_type=> "322")
      invoice.stub(:system_driven_event?).and_return(true)
      Org.current = FactoryGirl.build(:health_agency)
      invoice.stub(:update_status_date).and_return(true)
      expect { invoice.mark_as_denied}.to change {invoice.invoice_status}.from(:paid).to(:denied)
    end

    it "Should mark as denied from sent" do
      invoice = FactoryGirl.build(:invoice, :invoice_status=> :sent, :invoice_type=> "322")
      invoice.stub(:system_driven_event?).and_return(true)
      Org.current = FactoryGirl.build(:health_agency)
      invoice.stub(:update_status_date).and_return(true)
      expect { invoice.mark_as_denied}.to change {invoice.invoice_status}.from(:sent).to(:denied)
    end

    it "Should mark as denied from partially paid" do
      invoice = FactoryGirl.build(:invoice, :invoice_status=> :partially_paid, :invoice_type=> "322")
      invoice.stub(:system_driven_event?).and_return(true)
      Org.current = FactoryGirl.build(:health_agency)
      invoice.stub(:update_status_date).and_return(true)
      expect { invoice.mark_as_denied}.to change {invoice.invoice_status}.from(:partially_paid).to(:denied)
    end

    #event mark_as_paid

    it "Should mark as paid from  denied" do
      invoice = FactoryGirl.build(:invoice, :invoice_status=> :denied, :invoice_type=> "322")
      invoice.stub(:system_driven_event?).and_return(true)
      Org.current = FactoryGirl.build(:health_agency)
      invoice.stub(:update_status_date).and_return(true)
      expect { invoice.mark_as_paid}.to change {invoice.invoice_status}.from(:denied).to(:paid)
    end

    it "Should  paid from  sent" do
      invoice = FactoryGirl.build(:invoice, :invoice_status=> :sent, :invoice_type=> "322")
      invoice.stub(:system_driven_event?).and_return(true)
      Org.current = FactoryGirl.build(:health_agency)
      invoice.stub(:update_status_date).and_return(true)
      expect { invoice.mark_as_paid}.to change {invoice.invoice_status}.from(:sent).to(:paid)
    end

    it "Should  paid from  partially paid " do
      invoice = FactoryGirl.build(:invoice, :invoice_status=> :partially_paid, :invoice_type=> "322")
      invoice.stub(:system_driven_event?).and_return(true)
      Org.current = FactoryGirl.build(:health_agency)
      invoice.stub(:update_status_date).and_return(true)
      expect { invoice.mark_as_paid}.to change {invoice.invoice_status}.from(:partially_paid).to(:paid)
    end

    #event mark_as_partially_paid

    it "Should  paid from  partially paid " do
      invoice = FactoryGirl.build(:invoice, :invoice_status=> :denied, :invoice_type=> "322")
      invoice.stub(:system_driven_event?).and_return(true)
      Org.current = FactoryGirl.build(:health_agency)
      invoice.stub(:update_status_date).and_return(true)
      expect { invoice.mark_as_partially_paid}.to change {invoice.invoice_status}.from(:denied).to(:partially_paid)
    end

    it "Should  paid from sent " do
      invoice = FactoryGirl.build(:invoice, :invoice_status=> :sent, :invoice_type=> "322")
      invoice.stub(:system_driven_event?).and_return(true)
      Org.current = FactoryGirl.build(:health_agency)
      invoice.stub(:update_status_date).and_return(true)
      expect { invoice.mark_as_partially_paid}.to change {invoice.invoice_status}.from(:sent).to(:partially_paid)
    end

    it "Should  paid from  partially sent " do
      invoice = FactoryGirl.build(:invoice, :invoice_status=> :paid, :invoice_type=> "322")
      invoice.stub(:system_driven_event?).and_return(true)
      Org.current = FactoryGirl.build(:health_agency)
      invoice.stub(:update_status_date).and_return(true)
      expect { invoice.mark_as_partially_paid}.to change {invoice.invoice_status}.from(:paid).to(:partially_paid)
    end

  end
end