require 'spec_helper'

describe Document do

  let!(:document){FactoryGirl.build(:document)}

  subject {document}

  it "document status should be complete" do
    document = FactoryGirl.build(:document, status: :approved)
    document.status.should == :approved
  end

  it "document status should be exported" do
    document = FactoryGirl.build(:document, status: :exported)
    document.system_driven_event = true
    document.oasis_exports.stub(:exported_date_display)
    #document.export
    document.status.should == :exported
  end

  it "should return 'HH:MM' formatted time when i give time" do
    subject.formatted_time_display(Time.now)
  end

  it "should visit date, time in and time out for visit document" do
    subject.treatment_visit = TreatmentVisit.where(["draft_status = ?", false]).last
    subject.date_time_display.should_not be_empty
  end

  it "should return empty visit date, time in and time out for non visit document" do
    subject.date_time_display.should be_empty
  end

  context "Sign document" do
    context "current user is a visited fs" do
      context "Field staff signature required" do
        it "status should change Draft to Pending QA" do
          document =  FactoryGirl.build(:oasis_evaluation, status: :draft, valid: true, state_machine_id: '1')
          document.stub(:current_user_is_field_staff?).and_return(true)
          document.stub(:only_field_staff_signature_required?).and_return(true)
          document.stub(:field_signature_required?).and_return(true)
          document.stub(:create_document_note).and_return(true)
          document.stub(:change_visit_status).and_return(true)
          document.workflow.stub(:set_document_status).and_return do |*args|
            document.status = document.workflow.aasm_current_state
          end
          expect {document.sign}.to change {document.status}.from(:draft).to(:pending_qa)
        end
      end
    end

    context "current user is a Supervised user" do
        it "status should change Draft to Draft" do
          document =  FactoryGirl.build(:oasis_evaluation, status: :draft, valid: true, state_machine_id: '1')
          document.stub(:set_as_fs_signed).and_return(true)
          document.stub(:valid_document?).and_return(true)
          document.stub(:current_user_is_field_staff?).and_return(true)
          document.stub(:field_staff_signature_required?).and_return(true)
          document.stub(:supervisor_signature_required?).and_return(true)
          document.stub(:field_signature_required?).and_return(true)
          document.stub(:create_document_note).and_return(true)
          document.workflow.stub(:set_document_status).and_return do |*args|
            document.status = document.workflow.aasm_current_state
          end
          expect {document.sign}.not_to change {document.status}.from(:draft).to(:pending_qa)
        end
      end
  end

  context "Approved Document" do
    context "current user is a office staff" do
      it "status should change Pending QA to Approved" do
        document =  FactoryGirl.build(:oasis_evaluation, status: :pending_qa, valid: true, state_machine_id: '1')
        document.stub(:valid_document?).and_return(true)
        document.stub(:current_user_is_office_staff?).and_return(true)
        document.stub(:create_document_note).and_return(true)
        document.stub(:change_visit_status).and_return(true)
        document.stub(:on_document_ready).and_return(true)
        document.stub(:create_receivables).and_return(true)
        document.stub(:mark_episode_ready_to_bill).and_return(true)
        document.stub(:generate_hipps_code).and_return('1AFKX')
        document.stub(:inform_episode_doc_completed).and_return(true)
        document.stub(:create_oasis_export_if_required).and_return(true)
        document.stub(:archive_notes).and_return(true)
        document.workflow.stub(:set_document_status).and_return do |*args|
          document.status = document.workflow.aasm_current_state
        end
        expect {document.approve}.to change {document.status}.from(:pending_qa).to(:approved)
      end
    end
  end


  context "unlock document" do
    it "current user is a office staff status should change from Exported to draft(Export Rejected)" do
      document =  FactoryGirl.build(:oasis_evaluation, status: :exported, valid: true, state_machine_id: '4' )
      document.stub(:valid_document?).and_return(true)
      document.stub(:current_user_is_office_staff?).and_return(true)
      document.stub(:create_document_note).and_return(true)
      document.workflow.stub(:set_document_status).and_return do |*args|
        document.status = document.workflow.aasm_current_state
      end
      expect {document.set_unlock_reason('4')}.to change {document.status}.from(:exported).to(:draft)
    end

    it "current user is a office staff status should change from Exported to draft(Key Field Correction)" do
      document =  FactoryGirl.build(:oasis_evaluation, status: :exported, valid: true, state_machine_id: '2')
      document.stub(:valid_document?).and_return(true)
      document.stub(:current_user_is_office_staff?).and_return(true)
      document.stub(:create_document_note).and_return(true)
      document.workflow.stub(:set_document_status).and_return do |*args|
        document.status = document.workflow.aasm_current_state
      end
      expect {document.set_unlock_reason('2')}.to change {document.status}.from(:exported).to(:draft)
    end

    it "current user is a office staff status should change from Exported to draft(Non - Key Field Correction)" do
      document =  FactoryGirl.build(:oasis_evaluation, status: :exported, valid: true, state_machine_id: '3')
      document.stub(:valid_document?).and_return(true)
      document.stub(:current_user_is_office_staff?).and_return(true)
      document.stub(:create_document_note).and_return(true)
      document.workflow.stub(:set_document_status).and_return do |*args|
        document.status = document.workflow.aasm_current_state
      end
      expect {document.set_unlock_reason('3')}.to change {document.status}.from(:exported).to(:draft)
    end

    it "current user is a office staff status should change from Exported to draft(Clinical - Field Correction)" do
      document =  FactoryGirl.build(:oasis_evaluation, status: :exported, valid: true, state_machine_id: '5')
      document.stub(:create_document_note).and_return(true)
      expect {document.set_unlock_reason('5')}.to change {document.status}.from(:exported).to(:draft)
    end
  end
end

describe OasisExport do

  let!(:export){FactoryGirl.build(:oasis_export)}
  subject {:export}

  it "Oasis Export should be exported" do
    export =  FactoryGirl.build(:oasis_export, export_status: :exported)
    export.export_status.should be :exported
  end
end