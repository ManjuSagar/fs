require 'spec_helper'

describe DocumentsCompRelated do

  Org.current = Org.find(145)
  Object.send(:remove_const, :DummyClass) if Object.constants.include?(:DummyClass)
  class DummyClass < Netzke::Base
    include DocumentsCompRelated
  end

  it "should list all documents possible actions for particular organization" do
    dummy = DummyClass.new
    definitions = [FactoryGirl.build(:document_definition),
                   FactoryGirl.build(:document_definition, document_code: "CHHA_FU", document_name: "CHHA Evaluation")]
    actions = dummy.doc_actions_based_on_type(definitions, "add")
    actions.size.should == 2
  end

  it "should add prefix 'add' to actions when i pass prefix is 'add' for particular organization" do
    dummy = DummyClass.new
    definitions = [FactoryGirl.build(:document_definition),
                   FactoryGirl.build(:document_definition, document_code: "CHHA_FU", document_name: "CHHA Evaluation")]
    actions = dummy.doc_actions_based_on_type(definitions, "add")
    actions.should include(:add_chha_fu.action)
  end

  it "should add prefix 'attach' to actions when i pass prefix is 'attach' for particular organization" do
    dummy = DummyClass.new
    definitions = [FactoryGirl.build(:document_definition),
                   FactoryGirl.build(:document_definition, document_code: "CHHA_fu", document_name: "CHHA Evaluation")]
    actions = dummy.doc_actions_based_on_type(definitions, "attach")
    actions.should include(:attach_chha_fu.action)
  end

  it "should return add documents" do
    dummy = DummyClass.new
    definitions = [FactoryGirl.build(:document_definition),
                   FactoryGirl.build(:document_definition, document_code: "CHHA_EVAL", document_name: "CHHA Evaluation")]
    episode = FactoryGirl.build(:treatment_episode)
    treatment = dummy.stub(:treatment).and_return(FactoryGirl.build(:patient_treatment))
    treatment.stub(:patient)
    treatment.patient.stub(:patient_detail)
    treatment.patient.patient_detail.stub(:org)
    treatment.patient.patient_detail.org.stub(:document_definitions).and_return(definitions)
    actions = dummy.document_actions(treatment, episode)
    actions.should include(:add_chha_eval.action)
  end

  it "should return add and attach documents when i pass attachment required parameter" do
    dummy = DummyClass.new
    definitions = [FactoryGirl.build(:document_definition),
                   FactoryGirl.build(:document_definition, document_code: "CHHA_EVAL", document_name: "CHHA Evaluation")]
    episode = FactoryGirl.build(:treatment_episode)
    treatment = dummy.stub(:treatment).and_return(FactoryGirl.build(:patient_treatment))
    treatment.stub(:patient)
    treatment.patient.stub(:patient_detail)
    treatment.patient.patient_detail.stub(:org)
    treatment.patient.patient_detail.org.stub(:document_definitions).and_return(definitions)
    actions = dummy.document_actions(treatment, episode, true)
    actions.should include(:add_chha_eval.action)
    actions.should include(:attach_chha_eval.action)
  end

  it "should return add and attach documents and routesheet when i pass attachment and routesheet required parameters" do
    dummy = DummyClass.new
    definitions = [FactoryGirl.build(:document_definition),
                   FactoryGirl.build(:document_definition, document_code: "CHHA_EVAL", document_name: "CHHA Evaluation")]
    episode = FactoryGirl.build(:treatment_episode)
    treatment = dummy.stub(:treatment).and_return(FactoryGirl.build(:patient_treatment))
    treatment.stub(:patient)
    treatment.patient.stub(:patient_detail)
    treatment.patient.patient_detail.stub(:org)
    treatment.patient.patient_detail.org.stub(:document_definitions).and_return(definitions)
    actions = dummy.document_actions(treatment, episode, true, true)
    actions.should include(:add_chha_eval.action)
    actions.should include(:attach_chha_eval.action)
    actions.should include(:routesheet.action)
  end

end