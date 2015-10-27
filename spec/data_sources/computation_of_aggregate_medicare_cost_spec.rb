require 'spec_helper'

describe "ComputationAggregateMedicareCost" do

  before(:each) do
    @date = Date.parse("'2014'")
    Org.current = FactoryGirl.build(:health_agency)
  end

  describe "get_medicare_visit_count_group_by_discipline" do
    it "should_return_the_msa_codes" do
      cost_report = CostReportDataSource.new(:date=> @date)
       res = cost_report.msa_codes_list
      expect(res.is_a?(Array)).to eq true
    end

    it "should_return_visits_count" do
      cost_report = CostReportDataSource.new(:date=> @date)
      cost_report.msa_codes_list
      res = cost_report.treatment_visits_count
      expect(res.is_a?(Array)).to eq true
    end
  end
end