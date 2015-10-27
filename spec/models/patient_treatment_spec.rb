require 'spec_helper'

describe PatientTreatment do

  let!(:treatment){FactoryGirl.build(:patient_treatment)}

  subject { treatment }

  it "should have primary physician" do
    subject.stub(:treatment_physicians)
    subject.stub(:primary?)
    subject.stub(:physician)
    subject.primary_physician.stub(:full_name).and_return("Jeff Bronstein, MD")
    subject.primary_physician_name.should == "Jeff Bronstein, MD"
  end

  it "should return health agency" do
    subject.stub(:patient)
    subject.patient.stub(:org).and_return("Metro Health Agency")
    subject.health_agency.should == "Metro Health Agency"
  end

  it "should return either oasis eval or roc document" do
    documents = [FactoryGirl.build(:document, :document_type => "OasisEvaluation")]
    subject.stub(:documents).and_return(documents)
    subject.documents.stub(:order).and_return(documents)
    subject.oasis_eval_or_roc_document.should be_present
  end

  it "should return org week start day" do
    subject.stub(:patient)
    subject.patient.stub(:org_week_start_day).and_return("0")
    subject.org_week_start_day.should == "0"
  end

  it "should return language preference specified to be true" do
    subject.stub(:treatment_request)
    subject.stub(:language_preference_specified?).and_return(true)
    subject.language_preference_specified?.should be_true
  end

  it "should return patient zip code" do
    subject.stub(:patient)
    subject.patient.stub(:zip_code).and_return("90012")
    subject.zip_code.should == "90012"
  end

  it "should return medicare insurance" do
    subject.stub(:treatment_request)
    subject.stub(:medicare?).and_return(true)
    subject.should be_medicare
  end

end