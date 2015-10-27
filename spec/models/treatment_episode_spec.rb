require 'spec_helper'

describe TreatmentEpisode do
  let!(:episode) {
    FactoryGirl.build(:treatment_episode, initial_hipps_code: "1AFKS")
  }
  subject { episode }

  it 'should return hipps code when regenerate hipps code is false' do
    subject.get_hipps_code(false, nil).should_not be_nil
  end

  it 'hipps code should be equal to episode initial hipps code when regenerate hipps code is false' do
    subject.get_hipps_code(false, nil).should == subject.initial_hipps_code
  end

  it 'hipps code should be equal to episode initial hipps code when regenerate hipps code is false and no visits present' do
    subject.get_hipps_code(false, nil).should == subject.initial_hipps_code
  end

  it 'should return amount 4086.11 for the hipps code 3CFMX' do
    data = YAML::load(File.read("#{Rails.root}/static_data/unit_test/oasis_export_xml_generator/oasis_soc_doc_data.yml"))
    doc =  FactoryGirl.build(:oasis_evaluation, data: data)
    subject.treatment.stub(:episode_sequence_number).and_return(1)
    ha = FactoryGirl.build(:health_agency)
    doc.treatment.stub(:health_agency).and_return(ha)
    ha_detail = FactoryGirl.build(:health_agency_detail)
    doc.treatment.health_agency.stub(:health_agency_detail).and_return(ha_detail)
    score, bill_amount = subject.score_hipps_code_and_bill_amount({regenerate_hipps_code: true, doc: doc})
    grouping_points = [3,25,7,7,129]
    score.hipps_code == "3CFMX"
    bill_amount == 4086.11
    score.grouping_points == grouping_points
  end

  it "should be a RC episode" do
    episode = FactoryGirl.build(:treatment_episode, episode_status: "RC")
    episode.should be_is_recertified
  end

  it "should return patient full name" do
    episode.stub(:treatment)
    episode.treatment.stub(:to_s).and_return("Johnson Sam")
    episode.patient_name.should == "Johnson Sam"
  end

  it "should return true since oasis document present in the episode" do
    documents = [OasisEvaluation.new]
    episode.stub(:documents).and_return(documents)
    subject.oasis_document_completed_flag.should be_true
  end
end