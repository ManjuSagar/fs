require 'spec_helper'

describe "AlirtsReportByPrimaryDiagnosis" do

 describe "#get_patient_treatment_and_docs" do
   it "should return POC documents" do
    alirts_obj = ReportDataSource::AlirtsReportByPrimaryDiagnosis.new(2014, 2)
    docs = alirts_obj.get_patient_treatment_and_docs
    res = docs.all.collect{|x| x.documents.all.collect{|a| a.document_type = 'PlanOfCare'}}
    expect(res.is_a?(Array)).to eq true
   end
 end
 describe "#patients_visits_by_primary_diagnosis" do
   it "should return a array output" do
      list = ReportDataSource::VisitsNotCoveredByPlanOfCare.new({year: 2014})
      excess_visits = list.visits_not_covered_by_plan_of_care
      # User.current = User.find_by_email('fnpublic+help2@gmail.com')
      alirts_obj = ReportDataSource::AlirtsReportByPrimaryDiagnosis.new(2014, excess_visits)
      expect(alirts_obj.patients_visits_by_primary_diagnosis.is_a?(Array)).to eq true
   end
 end
end