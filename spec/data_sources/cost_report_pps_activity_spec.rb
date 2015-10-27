require 'spec_helper'

describe "PpsActivityData" do

  before(:each) do
    @date = Date.parse("'2014'")
    Org.current = FactoryGirl.build(:health_agency)
    @cost_report = ReportDataSource::CostReportPpsActivityData.new(2014)
  end

  describe "get_pps_activity_data" do
    it "should_return_the_msa_code" do
      cost_report = CostReportDataSource.new(:date=> @date)
      res = cost_report.msa_codes_list
      expect(res.is_a?(Array)).to eq true
    end

    it "should_return_pps_visits" do
      cost_report = CostReportDataSource.new(:date=> @date)
      res = cost_report.pps_visits
      expect(res.is_a?(Array)).to eq true
    end
  end

  describe "get_pps_activity_data" do
    it "should_return_the_array_of_pps_visits" do
      expect(@cost_report.pps_visits.is_a?(Array)).to eq true
    end

    it "should_return_the_array_of_pps_visits_by_discipline " do
      expect(@cost_report.get_pps_visits_list_by_discipline.is_a?(Array)).to eq true
    end
  end
end