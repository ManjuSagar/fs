require 'spec_helper'

describe "OasisExporterFor210And211" do

  it 'should return no errors' do
    document_template = DocumentFormTemplate.find_by_document_class_name("OasisEvalFormC1")
    oasis_eval = FactoryGirl.build(:oasis_evaluation, document_form_template: document_template)
    oasis_eval.data = YAML::load(File.read("#{Rails.root}/static_data/unit_test/oasis_export_xml_generator/oasis_soc_doc_data.yml"))
    ha = FactoryGirl.build(:health_agency)
    oasis_eval.stub(:treatment)
    oasis_eval.treatment.stub(:health_agency).and_return(ha)
    ha_detail = FactoryGirl.build(:health_agency_detail)
    oasis_eval.treatment.health_agency.stub(:health_agency_detail).and_return(ha_detail)
    oasis_eval.treatment.stub(:patient)
    oasis_eval.treatment.patient.stub(:patient_detail)
    oasis_eval.treatment.patient.patient_detail.stub(:org).and_return(ha)
    out_put = OasisExporterFor210And211.new(oasis_eval).generate_xml
    out_put.gsub(/\s/, "").should == File.read("#{Rails.root}/static_data/unit_test/oasis_export_xml_generator/success_xml.xml").gsub(/\s/, "")
  end

  it 'should return no errors for inactivation' do
    document_template = DocumentFormTemplate.find_by_document_class_name("OasisEvalFormC1")
    oasis_eval = FactoryGirl.build(:oasis_evaluation, document_form_template: document_template)
    oasis_eval.data = YAML::load(File.read("#{Rails.root}/static_data/unit_test/oasis_export_xml_generator/oasis_soc_doc_data_invalidation.yml"))
    ha = FactoryGirl.build(:health_agency)
    ha_detail = FactoryGirl.build(:health_agency_detail)
    oasis_eval.stub(:treatment)
    oasis_eval.treatment.stub(:health_agency).and_return(ha)
    oasis_eval.treatment.health_agency.stub(:health_agency_detail).and_return(ha_detail)
    oasis_eval.treatment.stub(:patient)
    oasis_eval.treatment.patient.stub(:patient_detail)
    oasis_eval.treatment.patient.patient_detail.stub(:org).and_return(ha)
    out_put = OasisExporterFor210And211.new(oasis_eval, 'Inactive').generate_xml
    out_put.gsub(/\s/, "").should == File.read("#{Rails.root}/static_data/unit_test/oasis_export_xml_generator/success_xml_invalidation.xml").gsub(/\s/, "")


  end
end